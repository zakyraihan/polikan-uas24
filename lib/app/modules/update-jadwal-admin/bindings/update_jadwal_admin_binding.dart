import 'package:get/get.dart';

import '../controllers/update_jadwal_admin_controller.dart';

class UpdateJadwalAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateJadwalAdminController>(
      () => UpdateJadwalAdminController(),
    );
  }
}
