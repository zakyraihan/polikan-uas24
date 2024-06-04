import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/data/usermodel.dart';
import 'package:polikan/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController role = TextEditingController();
  RxString selectedRole = ''.obs; // Role default

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<bool> isDuplicateEmail() async {
    final users = await userCollection.get();
    return users.docs.any((e) => e['email'] == emailController.text);
  }

  Future<void> register() async {
    isLoading.value = true;
    try {
      if (await isDuplicateEmail()) {
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
        email: emailController.text,
        password: passwordController.text,
      );

      final userModel = UserModel(
        id: '1',
        userName: userNameController.text,
        email: emailController.text,
        uid: credential.user?.uid ?? '',
        password: passwordController.text,
        role: role.text,
      );

      final user = await userCollection.add(userModel.toJson());

      await userCollection.doc(user.id).update({'id': user.id});

      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.white,
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

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user != null) {
        final userDoc = await userCollection.doc(user.uid).get();
        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final userRole = userData['role'];

          Get.back(); // Dismiss the loading dialog

          if (userRole == 'admin') {
            Get.offAllNamed(Routes.ADMIN);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          Get.back(); // Dismiss the loading dialog
          Get.snackbar(
            'Login Failed',
            'User data not found',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        Get.back(); // Dismiss the loading dialog
        Get.snackbar(
          'Login Failed',
          'Failed to get user data after login',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );
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
}
