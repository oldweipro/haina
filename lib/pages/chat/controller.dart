import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/api/conversation.dart';
import 'package:haina/common/util/prompt.dart';
import 'package:haina/model/chat/message.dart';
import 'package:haina/model/conversation.dart';
import 'package:haina/model/message.dart';
import 'package:haina/model/prompt.dart';
import 'package:haina/model/response_result.dart';
import 'package:haina/pages/chat/state.dart';

class ChatController extends GetxController {
  final state = ChatState();

  final messageList = <Message>[].obs;
  final prompts = <Prompt>[].obs;

  final conversationList = <Conversation>[].obs;
  final currentConversationUuid = "".obs;

  final textEditingController = TextEditingController();

  // 定义一个 GlobalKey
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  @override
  void onInit() async {
    prompts.value = await getPrompts();
    ConversationRequest request = ConversationRequest(conversationType: 0);
    HainaResponse<ConversationData> response =
    await ConversationApi.getCurrentUserConversationList(params: request);
    conversationList.value = await ConversationRepository().getConversations();
    print("object: ${response.data}");
    super.onInit();
  }

  // 加载所有消息
  void loadAllMessages() async {
    // 获取当前用户的聊天记录
    ConversationRequest request = ConversationRequest(conversationType: 0);
    HainaResponse response =
    await ConversationApi.getCurrentUserConversationList(params: request);
    // messageList.value = await ConversationRepository()
    //     .getMessagesByConversationUUid(conversationUUid);
  }

  void addMessage(Message message) async {
    await ConversationRepository().addMessage(message);
    final messages = await ConversationRepository()
        .getMessagesByConversationUUid(message.conversationId);
    messageList.value = messages;
    // wait for all the  state emit
    final completer = Completer();
    try {
      // TODO 请求接口
      MessageRepository().postMessage(message, (Message message) {
        messageList.value = [...messages, message];
      }, (Message message) {
        messageList.value = [...messages, message];
      }, (Message message) async {
        // if streaming is done ,load all the message
        ConversationRepository().addMessage(message);
        final messages = await ConversationRepository()
            .getMessagesByConversationUUid(message.conversationId);
        messageList.value = messages;
        completer.complete();
      });
    } catch (e) {
      messageList.value = [
        ...messages,
        Message(
            conversationId: message.conversationId,
            text: e.toString(),
            role: Role.assistant)
      ];
      completer.complete();
    }
    await completer.future;
  }

  // conversation
  void setCurrentConversationUuid(String uuid) async {
    currentConversationUuid.value = uuid;
    update();
  }

  void deleteConversation(int index) async {
    Conversation conversation = conversationList[index];
    await ConversationRepository().deleteConversation(conversation.uuid);
    conversationList.value = await ConversationRepository().getConversations();
    update();
  }

  void renameConversation(Conversation conversation) async {
    await ConversationRepository().updateConversation(conversation);
    conversationList.value = await ConversationRepository().getConversations();
    update();
  }

  void addConversation(Conversation conversation) async {
    await ConversationRepository().addConversation(conversation);
    conversationList.value = await ConversationRepository().getConversations();
    update();
  }
}
