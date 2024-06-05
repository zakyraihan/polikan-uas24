// To parse this JSON data, do
//
//     final jadwalPoli = jadwalPoliFromJson(jsonString);

import 'dart:convert';

JadwalPoli jadwalPoliFromJson(String str) => JadwalPoli.fromJson(json.decode(str));

String jadwalPoliToJson(JadwalPoli data) => json.encode(data.toJson());

class JadwalPoli {
    String namaDokter;
    String spesialis;
    DateTime jamPraktek;
    String lokasi;
    String kontak;
    String informasiTambahan;

    JadwalPoli({
        required this.namaDokter,
        required this.spesialis,
        required this.jamPraktek,
        required this.lokasi,
        required this.kontak,
        required this.informasiTambahan,
    });

    factory JadwalPoli.fromJson(Map<String, dynamic> json) => JadwalPoli(
        namaDokter: json["namaDokter"],
        spesialis: json["spesialis"],
        jamPraktek: json["jamPraktek"],
        lokasi: json["lokasi"],
        kontak: json["kontak"],
        informasiTambahan: json["informasiTambahan"],
    );

    Map<String, dynamic> toJson() => {
        "namaDokter": namaDokter,
        "spesialis": spesialis,
        "jamPraktek": jamPraktek,
        "lokasi": lokasi,
        "kontak": kontak,
        "informasiTambahan": informasiTambahan,
    };
}
