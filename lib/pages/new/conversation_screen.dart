import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/api/conversation.dart';
import 'package:haina/common/router/router.dart';
import 'package:haina/common/store/store.dart';
import 'package:haina/model/conversation.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  void getProductListFunc() async {
    HainaResponse res = await ConversationApi.getProductList();
    print(res);
  }
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
              getProductListFunc();
            },
            child: const Text("test"),
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
