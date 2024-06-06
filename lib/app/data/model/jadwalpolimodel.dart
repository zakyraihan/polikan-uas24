// To parse this JSON data, do
//
//     final jadwalPoli = jadwalPoliFromJson(jsonString);

import 'dart:convert';

JadwalPoli jadwalPoliFromJson(String str, String id) =>
    JadwalPoli.fromJson(json.decode(str), id);

String jadwalPoliToJson(JadwalPoli data) => json.encode(data.toJson());

class JadwalPoli {
  // String id;
  String namaDokter;
  String codePoli;
  String spesialis;
  DateTime jamPraktek;
  String lokasi;
  String kontak;
  String informasiTambahan;

  JadwalPoli({
    // required this.id,
    required this.namaDokter,
    required this.codePoli,
    required this.spesialis,
    required this.jamPraktek,
    required this.lokasi,
    required this.kontak,
    required this.informasiTambahan,
  });

  factory JadwalPoli.fromJson(Map<String, dynamic> json, String id) =>
      JadwalPoli(
        // id: json["id"],
        namaDokter: json["namaDokter"],
        codePoli: json["codePoli"],
        spesialis: json["spesialis"],
        jamPraktek: json["jamPraktek"],
        lokasi: json["lokasi"],
        kontak: json["kontak"],
        informasiTambahan: json["informasiTambahan"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "namaDokter": namaDokter,
        "codePoli": codePoli,
        "spesialis": spesialis,
        "jamPraktek": jamPraktek,
        "lokasi": lokasi,
        "kontak": kontak,
        "informasiTambahan": informasiTambahan,
      };
}
