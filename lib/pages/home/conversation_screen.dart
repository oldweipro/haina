import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/common/router/router.dart';
import 'package:haina/common/store/store.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 7),
          ElevatedButton(
            onPressed: () {
              Get.toNamed<void>(AppRoutes.setting);
            },
            child: const Text("按钮"),
          ),
          const SizedBox(height: 7),
          const Text("😂哈哈哈"),
          const SizedBox(height: 7),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.chat);
              // Get.toNamed(AppRoutes.chatOld);
            },
            child: const Text("聊天页面"),
          ),
          ElevatedButton(
            onPressed: () {
              UserStore.to.onLogout();
            },
            child: const Text("退出登陆"),
          ),
        ],
      ),
    );
  }
}
