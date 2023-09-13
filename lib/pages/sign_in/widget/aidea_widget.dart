import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final phoneNumberValidator = RegExp(r"^1[3456789]\d{9}$");

  var agreeProtocol = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 96.0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.yellow,
          ),
          onPressed: () {
            // if (context.canPop()) {
            //   context.pop();
            // } else {
            //   context.go('/chat-chat');
            // }
          },
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/app.png'),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    controller: _usernameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(200, 192, 192, 192)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueAccent ?? Colors.green),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.blueAccent ?? Colors.green,
                      ),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: '账号',
                      labelStyle: const TextStyle(fontSize: 17),
                      hintText: '密码',
                      hintStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    '未注册的手机号验证成功后将自动注册',
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // 登录按钮
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: onSigninSubmit,
                    child: const Text(
                      '验证',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           // 找回密码
                //           TextButton(
                //             onPressed: () {
                //               context.push(
                //                   '/retrieve-password?username=${_usernameController.text.trim()}');
                //             },
                //             child: Text(
                //               AppLocale.forgotPassword.getString(context),
                //               style: TextStyle(
                //                 color: customColors.weakLinkColor,
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ),
                //           // 创建账号
                //           TextButton(
                //               onPressed: () {
                //                 context
                //                     .push(
                //                         '/signup?username=${_usernameController.text.trim()}')
                //                     .then((value) {
                //                   if (value != null) {
                //                     _usernameController.text = value as String;
                //                   }
                //                 });
                //               },
                //               child: Text(
                //                 AppLocale.createAccount.getString(context),
                //                 style: TextStyle(
                //                   color: customColors.linkColor,
                //                   fontSize: 14,
                //                 ),
                //               )),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool processing = false;

  onAppleSigninSubmit() async {
  }

  onSigninSubmit() {
  }
}
