import 'package:get/get.dart';
import 'package:haina/pages/old/controller.dart';

class OldBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OldController>(() => OldController());
  }
}
