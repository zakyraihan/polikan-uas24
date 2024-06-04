import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isObscure = true.obs;

  obscureFunc() {
    isObscure.value = !isObscure.value;
  }
}
