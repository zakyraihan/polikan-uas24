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
  RxString selectedRole = ''.obs; // Role default

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  isDuplicateEmail() async {
    final users = await userCollection.get();
    return users.docs.any((e) => e['email'] == emailController.text);
  }

  register() async {
    isLoading.value = true;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final userModel = UserModel(
        id: '1',
        uid: credential.user?.uid ?? '',
        userName: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        role: selectedRole.value,
      );

      final user = await userCollection.add(userModel.toJson());

      await userCollection.doc(user.id).update({'id': user.id});

      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.blue,
        title: 'Berhasil Register',
        message: 'Diarahkan Ke Halaman Login',
        duration: Duration(seconds: 2),
      )).future.then((value) => Get.offAllNamed(Routes.LOGIN));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const GetSnackBar(
          backgroundColor: Colors.red,
          title: 'Something Went Wrong',
          message: 'Maaf, Password Kurang',
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'email-already-in-use') {
        const GetSnackBar(
          backgroundColor: Colors.red,
          title: 'Something Went Wrong',
          message: 'Maaf, Email Sudah Terdaftar',
          duration: Duration(seconds: 3),
        );
      }
    } catch (e, st) {
      log('Error from $e, stack trace $st');
      GetSnackBar(
        title: 'Something Went Wrong',
        message: 'Sorry, $e',
        duration: const Duration(seconds: 3),
      );
    }
    isLoading.value = false;
  }
}
