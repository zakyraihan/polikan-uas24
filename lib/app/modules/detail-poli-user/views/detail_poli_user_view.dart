import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_poli_user_controller.dart';

class DetailPoliUserView extends GetView<DetailPoliUserController> {
  const DetailPoliUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPoliUserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPoliUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
