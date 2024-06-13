import 'package:get/get.dart';

import '../controllers/jadwal_poli_admin_controller.dart';

class JadwalPoliAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalPoliAdminController>(
      () => JadwalPoliAdminController(),
    );
  }
}
