import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/api/user.dart';
import 'package:haina/model/conversation.dart';
import 'package:haina/model/user.dart';
import 'package:haina/pages/sign_in/state.dart';
import 'package:haina/router/router.dart';
import 'package:haina/store/user.dart';

class SignInController extends GetxController {
  final state = SignInState();

  SignInController();

  // email的控制器
  final TextEditingController emailController = TextEditingController();

  // 密码的控制器
  final TextEditingController passController = TextEditingController();

  // final MyRepository repository;
  // SignInController({@required this.repository}) : assert(repository != null);

  // 跳转 注册界面
  // handleNavSignUp() {
  //   Get.toNamed(AppRoutes.SIGN_UP);
  // }

  // 忘记密码
  // handleFogotPassword() {
  //   toastInfo(msg: '忘记密码');
  // }

  // 执行登录操作
  handleSignIn() async {
    // if (!duIsEmail(_emailController.value.text)) {
    //   toastInfo(msg: '请正确输入邮件');
    //   return;
    // }
    // if (!duCheckStringLength(_passController.value.text, 6)) {
    //   toastInfo(msg: '密码不能小于6位');
    //   return;
    // }

    UserLoginRequestEntity params = UserLoginRequestEntity(
      email: emailController.value.text,
      password: passController.value.text,
    );

    ConversationResponse userProfile = await UserApi.login(
      params: params,
    );
    Map<String, dynamic> user = userProfile.data as Map<String, dynamic>;
    UserStore.to.setToken(user["token"]);
    UserStore.to.saveProfile(user);
    if (UserStore.to.isLogin) {
      Get.offAndToNamed(AppRoutes.initial);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
