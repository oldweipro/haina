import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haina/pages/sign_in/controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  Widget _buildInputForm() {
    return Container(
      width: 295.w,
      // height: 204,
      margin: EdgeInsets.only(top: 49.h),
      child: Column(
        children: [
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.account_box_outlined),
              labelText: '邮箱',
              hintText: '请输入邮箱',
              // helperText: 'supporting text',
              filled: true,
            ),
          ),
          TextField(
            controller: controller.passController,
            obscureText: controller.state.passwordVisible.value,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.keyboard_alt_outlined),
              labelText: '密码',
              hintText: '请输入密码',
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.state.passwordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: controller.onPressedVisiblePassword,
              ),
            ),
          ),

          // 注册、登录 横向布局
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: controller.handleSignIn,
                    child: const Text("登录")),
                const Spacer(),
              ],
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<SignInController>(
      init: controller,
      builder: (controller) => Scaffold(
        body: Center(
          child: Column(
            children: [
              _buildInputForm(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
