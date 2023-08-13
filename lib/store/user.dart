import 'dart:convert';

import 'package:get/get.dart';
import 'package:haina/api/user.dart';
import 'package:haina/constant/storage.dart';
import 'package:haina/model/user.dart';
import 'package:haina/router/router.dart';
import 'package:haina/service/service.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  // 令牌 token
  String token = '';

  // 用户 profile
  final _profile = UserLoginResponseEntity().obs;

  bool get isLogin => _isLogin.value;

  UserLoginResponseEntity get profile => _profile.value;

  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    // var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    // if (profileOffline.isNotEmpty) {
    //   _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    // }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  // 获取 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;
    var result = await UserApi.profile();
    _profile(result);
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(result));
  }

  // 保存 profile
  Future<void> saveProfile(Map<String, dynamic> profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
  }

  // 注销
  Future<void> onLogout() async {
    if (_isLogin.value) await UserApi.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAndToNamed(AppRoutes.signIn);
  }
}
