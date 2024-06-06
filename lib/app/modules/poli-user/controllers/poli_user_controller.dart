import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/model/jadwalpolimodel.dart';

class PoliUserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool status = false.obs;
  List<JadwalPoli> data = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> streamJadwalPoli() async* {
    yield* firestore.collection('jadwal-poli').snapshots();
  }

  getPoliUser() async {
    // status.value = true;
    try {
      final hasil = await firestore.collection('jadwal-poli').get();
      if (hasil.docs.isNotEmpty) {
        hasil.docs.map((e) {
          JadwalPoli dataList = JadwalPoli.fromJson(Map.from(e.data()), e.id);
          data.add(dataList);
        }).toList();
      }
    } catch (e) {
      log('gagal mengambil poli user --> $e');
    }
    status.value = true;
  }
}
