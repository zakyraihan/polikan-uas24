import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/controllers/auth_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final authController = Get.put(AuthController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: lebar,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  final user = profileController.user.value;
                  return Text(
                    user?.displayName ?? 'User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const ListTile(
                    leading: Icon(Icons.cake, color: Colors.purple),
                    title: Text('Birthday'),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.purple),
                    title: Text('Instagram account'),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: const Icon(Icons.email, color: Colors.purple),
                    title: Obx(() {
                      final user = profileController.user.value;
                      return Text(user?.email ?? 'Email');
                    }),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => authController.logOut(),
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.purple,
                      // onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Log Out'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
