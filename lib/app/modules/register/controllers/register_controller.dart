import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class RegisterController extends GetxController {
  RxBool isObscure = true.obs;

  obscureFunc() {
    isObscure.value = !isObscure.value;
  }
}
