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
              prefixIcon: Icon(Icons.search),
              labelText: '邮箱',
              hintText: '请输入邮箱',
              // helperText: 'supporting text',
              filled: true,
            ),
          ),
          TextField(
            controller: controller.passController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: '密码',
              hintText: '请输入密码',
              // helperText: 'supporting text',
              filled: true,
            ),
          ),
          // // email input
          // inputTextEdit(
          //   controller: controller.emailController,
          //   keyboardType: TextInputType.emailAddress,
          //   hintText: "邮箱",
          //   marginTop: 0,
          //   // autofocus: true,
          // ),
          // // password input
          // inputTextEdit(
          //   controller: controller.passController,
          //   keyboardType: TextInputType.visiblePassword,
          //   hintText: "密码",
          //   isPassword: true,
          // ),

          // 注册、登录 横向布局
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: controller.handleSignIn, child: Text("登录")),
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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildInputForm(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
