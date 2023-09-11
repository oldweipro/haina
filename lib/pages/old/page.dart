import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/component/chat.dart';
import 'package:haina/component/conversation.dart';
import 'package:haina/pages/old/controller.dart';

class OldPage extends GetResponsiveView<OldController> {
  OldPage({super.key});

  @override
  Widget? phone() {
    return Scaffold(
      appBar: AppBar(
        title: Text('appTitle'.tr),
      ),
      drawer: const ConversationWindow(),
      body: const ChatWindow(),
    );
  }

  @override
  Widget? desktop() {
    return const Scaffold(
      body: Row(
        children: [
          ConversationWindow(),
          Expanded(child: ChatWindow()),
        ],
      ),
    );
  }
}
