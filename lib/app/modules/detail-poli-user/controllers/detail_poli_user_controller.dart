import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polikan/app/data/model/jadwalpolimodel.dart';

class DetailPoliUserController extends GetxController {
  RxBool isOpen = false.obs;
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noteleponController = TextEditingController();

  CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('booking');

  FirebaseAuth auth = FirebaseAuth.instance;

  bookingJadwal(JadwalPoli poli) async {
    String currentUserId = auth.currentUser?.uid ?? '';
    Map<String, dynamic> bookingData = {
      "namaDokter": poli.namaDokter,
      "codePoli": poli.codePoli,
      "jam": poli.jamPraktek,
      "spesialis": poli.spesialis,
      "nama": namaController.text,
      "alamat": alamatController.text,
      "tanggalBooking": DateTime.now(),
      "notelepon": noteleponController.text,
      'userId': currentUserId,
    };

    // Save the booking data to Firestore
    try {
      var hasil = await bookingCollection.add(bookingData);
      await bookingCollection.doc(hasil.id).update({'codePoli': hasil.id});

      Get.snackbar(
        "Booking Successful",
        "Your booking has been added successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Booking Failed",
        "There was an error while booking: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
