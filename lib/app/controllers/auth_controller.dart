import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:polikan/app/data/model/usermodel.dart';
import 'package:polikan/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAdmin = false.obs;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  bool _isAdmin = false;

  set isAdminFunc(bool value) {
    _isAdmin = value;
  }

  Future<bool> isDuplicateEmail(String email) async {
    final users = await userCollection.get();
    return users.docs.any((e) => e['email'] == email);
  }

  Future<void> register({
    required bool isAdmin,
    required String userName,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      if (await isDuplicateEmail(email)) {
        Get.snackbar(
          'Something Went Wrong',
          'Maaf, Email Sudah Terdaftar',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
        isLoading.value = false;
        return;
      }

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _isAdmin = isAdmin;

      final userModel = UserModel(
        userName: userName,
        email: email,
        uid: credential.user?.uid ?? '',
        password: password,
        isAdmin: _isAdmin,
      );

      await userCollection.doc(userModel.uid).set(userModel.toJson());

      Get.showSnackbar(const GetSnackBar(
        title: 'Berhasil Register',
        message: 'Diarahkan Ke Halaman Login',
        duration: Duration(seconds: 2),
      )).future.then((value) => Get.offAllNamed(Routes.LOGIN));
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Something Went Wrong',
          'Maaf, Password Kurang',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Something Went Wrong',
          'Maaf, Email Sudah Terdaftar',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, st) {
      isLoading.value = false;
      log('Error from $e, stack trace $st');
      Get.snackbar(
        'Something Went Wrong',
        'Sorry, $e',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      );
    }
    isLoading.value = false;
  }

  Future<void> login(String email, String password) async {
    try {
      Get.defaultDialog(
        content: const CircularProgressIndicator(),
        title: 'Loading...',
      );

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userDoc = await userCollection.doc(credential.user?.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;

        if (data != null) {
          final isAdmin = data['isAdmin'] ?? false;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setBool('isAdmin', isAdmin);

          Get.back(); // Dismiss the loading dialog

          if (isAdmin) {
            Get.offAllNamed(Routes.ADMIN);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          Get.back();
          print('Data pengguna kosong');
        }
      } else {
        Get.back();
        print('Dokumen pengguna tidak ditemukan');
      }
    } on FirebaseAuthException catch (e) {
      Get.back(); // Dismiss the loading dialog
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Login Failed',
          'No user found for that email.',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Login Failed',
          'Wrong password provided for that user.',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.back(); // Dismiss the loading dialog
      Get.snackbar(
        'Login Failed',
        'Error: $e',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('isAdmin');
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<String> _determineHomeRoute(String uid) async {
    try {
      final userDoc = await userCollection.doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        final isAdmin = data['isAdmin'] ?? false;
        return isAdmin ? Routes.ADMIN : Routes.HOME;
      }
    } catch (error) {
      log('Error determining home route: $error');
    }
    return Routes.LOGIN;
  }

  Future<String> get autoLoginRoute async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await _determineHomeRoute(user.uid);
    } else {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final isAdmin = prefs.getBool('isAdmin') ?? false;

      if (isLoggedIn) {
        return isAdmin ? Routes.ADMIN : Routes.HOME;
      } else {
        return Routes.LOGIN;
      }
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      try {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.defaultDialog(middleText: "Gagal Login Google", title: "Error");
      }
    }
  }
}
