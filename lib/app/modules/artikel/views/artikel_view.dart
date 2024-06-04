import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/artikel_controller.dart';

class ArtikelView extends GetView<ArtikelController> {
  const ArtikelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArtikelView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ArtikelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
