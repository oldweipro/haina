import 'package:get/get.dart';

class SignInState {
  final _obj = ''.obs;
  Rx<bool> passwordVisible = true.obs;

  set obj(value) => _obj.value = value;

  get obj => _obj.value;
}
