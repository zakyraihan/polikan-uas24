// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/controllers/auth_controller.dart';
import 'package:polikan/app/modules/login/views/login_view.dart';

class RegisterView extends GetView<AuthController> {
  final c = Get.put(AuthController());

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(height: 40),
            const Icon(Icons.bloodtype, size: 50, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'REGISTER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.userNameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: Obx(() {
                return TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isLoading.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none, // Menghilangkan garis bawah
                    contentPadding: const EdgeInsets.all(8.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isLoading.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.isLoading.value =
                            !controller.isLoading.value;
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                );
              }),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.white,
                        // onPrimary: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () => c.register(),
                      child: const Text('CREATE ACCOUNT'),
                    );
            }),

            TextButton(
              onPressed: () {
                Get.to(() => LoginView());
              },
              child: Text("sudah punya akun?", style: TextStyle(
                color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
