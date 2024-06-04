import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'AdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          
        },
        child: const Icon(
          Icons.qr_code_scanner_rounded,
        ),
      ),
    );
  }
}
