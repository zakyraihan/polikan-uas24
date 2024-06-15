import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/data/model/jadwalpolimodel.dart';

class UpdateJadwalAdminController extends GetxController {
  TextEditingController namaDokterController = TextEditingController();
  TextEditingController spesialisController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController kontakController = TextEditingController();
  TextEditingController codePoliController = TextEditingController();
  TextEditingController informasiTambahanController = TextEditingController();
  DateTime? selectedDate;
  RxBool isLoading = false.obs;

  final JadwalPoli poli = Get.arguments;
  CollectionReference poliCollection =
      FirebaseFirestore.instance.collection('jadwal-poli');

  @override
  void onInit() {
    namaDokterController.text = poli.namaDokter;
    spesialisController.text = poli.spesialis;
    lokasiController.text = poli.lokasi;
    kontakController.text = poli.kontak;
    selectedDate = poli.jamPraktek.toDate();
    informasiTambahanController.text = poli.informasiTambahan;
    super.onInit();
  }

  Future<void> updatePoli() async {
    isLoading.value = true;

    try {
      final poliModel = JadwalPoli(
        codePoli: poli.codePoli,
        namaDokter: namaDokterController.text,
        spesialis: spesialisController.text,
        jamPraktek: Timestamp.fromMicrosecondsSinceEpoch(selectedDate!.day),
        lokasi: lokasiController.text,
        kontak: kontakController.text,
        informasiTambahan: informasiTambahanController.text,
      );

      await poliCollection.doc(poli.codePoli).update(poliModel.toJson());

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Berhasil update Jadwal',
        duration: Duration(seconds: 2),
      ));

    } catch (e) {
      log('Error membuat jadwal ---> $e');
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: 'Gagal update Jadwal: $e',
        duration: const Duration(seconds: 2),
      ));
    } finally {
      isLoading.value = false;
    }
  }
}
