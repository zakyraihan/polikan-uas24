import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamBooking() async* {
    String currentUserId = auth.currentUser?.uid ?? '';

    yield* firestore
        .collection('booking')
        .where('userId', isEqualTo: currentUserId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSelesai() async* {
    String currentUserId = auth.currentUser?.uid ?? '';
    yield* firestore
        .collection('selesai')
        .where('userId', isEqualTo: currentUserId)
        .snapshots();
  }
}
