import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/data/model/jadwalpolimodel.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../controllers/poli_user_controller.dart';

class PoliUserView extends GetView<PoliUserController> {
  const PoliUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PoliUserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PoliUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
