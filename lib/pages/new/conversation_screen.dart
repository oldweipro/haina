import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/router/router.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 7),
          ElevatedButton(
            onPressed: () {
              Get.toNamed<void>(AppRoutes.setting);
            },
            child: Text("按钮"),
          ),
          Text("😂哈哈哈"),
        ],
      ),
    );
  }
}
