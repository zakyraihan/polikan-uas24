import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/controllers/auth_controller.dart';
import 'package:polikan/app/modules/login/controllers/login_controller.dart';
import 'package:polikan/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final c = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bloodtype, size: 50, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    'LOGIN',
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
                      controller: controller.emailC,
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
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller.passwordC,
                        obscureText: controller.isObscure.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8.0),
                          suffixIcon: IconButton(
                              icon: Icon(
                                controller.isObscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () => controller.obscureFunc()),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return c.isLoading.value
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
                            onPressed: () => c.login(
                              controller.emailC.text,
                              controller.passwordC.text,
                            ),
                            child: const Text('LOGIN'),
                          );
                  }),
                  const SizedBox(height: 10),
                  const Divider(),
                  TextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER),
                      child: const Text('Belum Punya Akun? Register')),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => c.signInWithGoogle(),
                        child: const Text('Google'),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
