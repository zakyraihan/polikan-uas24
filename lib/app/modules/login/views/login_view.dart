import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final c = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
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
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller.passwordController,
                        obscureText: !controller.isLoading.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: InputBorder.none,
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
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  // Obx(() {
                  //   return controller.isLoading.value
                  //       ? const CircularProgressIndicator(color: Colors.white)
                  //       : ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             // primary: Colors.white,
                  //             // onPrimary: Colors.pinkAccent,
                  //             padding: const EdgeInsets.symmetric(
                  //               horizontal: 50,
                  //               vertical: 15,
                  //             ),
                  //           ),
                  //           onPressed: () => c.login(),
                  //           child: const Text('LOGIN'),
                  //         );
                  // }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
