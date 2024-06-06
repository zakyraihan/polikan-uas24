import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/data/model/jadwalpolimodel.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../controllers/poli_user_controller.dart';

class PoliUserView extends GetView<PoliUserController> {
  const PoliUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PoliUserView'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamJadwalPoli(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tidak Ada Jadwal Poli'));
          }

          List<JadwalPoli> allPoli = [];

          for (var e in snapshot.data!.docs) {
            allPoli.add(JadwalPoli.fromJson(e.data(), ''));
          }

          return ListView.builder(
            itemCount: allPoli.length,
            itemBuilder: (context, index) {
              JadwalPoli poli = allPoli[index];
              return TicketWidget(
                width: 100,
                height: 50,
                child: Column(
                  children: [
                    Text(poli.namaDokter),
                    Text(poli.jamPraktek.toString()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
