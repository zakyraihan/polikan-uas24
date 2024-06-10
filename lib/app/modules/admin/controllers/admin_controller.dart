import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:polikan/app/modules/detail-poli-user/model/booking_model.dart';

class AdminController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Booking> allBooking = List<Booking>.empty().obs;

  void openScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#000000',
      'Cancel',
      true,
      ScanMode.QR,
    );

    // Membuat batch transaksi Firestore
    WriteBatch batch = firestore.batch();

    try {
      // Membaca data dari dokumen di koleksi 'booking'
      DocumentReference bookingRef =
          firestore.collection('booking').doc(barcodeScanRes);
      DocumentSnapshot bookingSnapshot = await bookingRef.get();

      if (bookingSnapshot.exists) {
        // Mendapatkan data dari dokumen 'booking'
        Map<String, dynamic> bookingData =
            bookingSnapshot.data() as Map<String, dynamic>;

        // Menghapus dokumen dari koleksi 'booking'
        batch.delete(bookingRef);

        // Menambahkan data yang sama ke koleksi 'selesai'
        CollectionReference selesaiCollection = firestore.collection('selesai');
        batch.set(selesaiCollection.doc(), bookingData);

        // Menjalankan batch transaksi
        await batch.commit();

        print('Data berhasil dipindahkan dari "booking" ke "selesai".');
      } else {
        print(
            'Dokumen dengan ID yang dipindai tidak ditemukan dalam koleksi "booking".');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  void bookingPdf() async {
    final pdf = pw.Document();

    // reset all product -> untuk mengatasi duplikat
    allBooking([]);
    // mengambil isi data product dari firebase collection
    var getData = await firestore.collection('booking').get();
    for (var element in getData.docs) {
      allBooking.add(Booking.fromJson(element.data()));
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allBooking.length,
            (index) {
              Booking data = allBooking[index];
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      '${index + 1}',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      data.nama,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      data.alamat,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      data.notelepon,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return [
            pw.Padding(
              padding: const pw.EdgeInsets.all(0),
              child: pw.Center(
                child: pw.Text(
                  'Pasien',
                  style: const pw.TextStyle(fontSize: 20),
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColor.fromHex('#000000'),
                width: 2,
              ),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'No',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'Nama Pasien',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'alamat',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(
                        'no telepon',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                // isi data
                ...allData,
              ],
            )
          ];
        },
      ),
    );

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    var dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/pasienbooking.pdf');

    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }
}
