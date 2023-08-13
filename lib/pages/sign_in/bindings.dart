import 'package:get/get.dart';
import 'package:haina/pages/sign_in/controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
