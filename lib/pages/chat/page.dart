import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:haina/component/markdown.dart';
import 'package:haina/model/conversation.dart';
import 'package:haina/model/prompt.dart';
import 'package:haina/pages/chat/controller.dart';
import 'package:haina/pages/chat/widget/prompts.dart';
import 'package:uuid/uuid.dart';
var uuid = const Uuid();
class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: _message(),
            ),
          const SizedBox(height: 16),
          // 输入框
          Form(
            key: controller.formKey, // 将 GlobalKey 赋值给 Form 组件的 key 属性
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: _handleKeyEvent,
              child: Row(
                children: [
                  Expanded(
                    // 输入框
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13),
                      controller: controller.textEditingController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "inputPrompt".tr,
                        hintText: "inputPromptTips".tr,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Conversation _newConversation(String name, String description) {
    var conversation = Conversation(
      name: name,
      description: description,
      uuid: uuid.v4(),
    );
    return conversation;
  }

  void _sendMessage() {
    final message = controller.textEditingController.text.trim();
    // final ChatController controller = Get.find();
    // final ConversationController conversationController = Get.find();
    if (message.isNotEmpty) {
      var conversationUuid =
          controller.currentConversationUuid.value;
      if (conversationUuid.isEmpty) {
        // new conversation
        //message 的前10个字符，如果message不够10个字符，则全部
        var conversation = _newConversation(
            message.substring(0, message.length > 20 ? 20 : message.length),
            message);
        conversationUuid = conversation.uuid;
        controller.setCurrentConversationUuid(conversationUuid);
        controller.addConversation(conversation);
      }
      final newMessage = Message(
        conversationId: conversationUuid,
        role: Role.user,
        text: message,
      );
      controller.addMessage(newMessage);
      controller.formKey.currentState!.reset();
    }
  }

  Widget _buildMessageCard(Message message) {
    if (message.role == Role.user) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FaIcon(FontAwesomeIcons.person),
              SizedBox(
                width: 5,
              ),
              Text("User"),
              SizedBox(
                width: 10,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        message.text,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              const FaIcon(FontAwesomeIcons.robot),
              const SizedBox(
                width: 5,
              ),
              Text(message.role == Role.system ? "System" : "assistant"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(8),
                  child: Markdown(text: message.text),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  void _handleKeyEvent(RawKeyEvent value) {
    if (value.isKeyPressed(LogicalKeyboardKey.enter)) {
      _sendMessage();
    }
  }

  void _scrollToNewMessage() {
    if (controller.scrollController.hasClients) {
      controller.scrollController.jumpTo(controller.scrollController.position.maxScrollExtent);
    }
  }

  Widget _message() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToNewMessage();
    });
    if (controller.messageList.isNotEmpty) {
      return ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.messageList.length,
        itemBuilder: (context, index) {
          return _buildMessageCard(controller.messageList[index]);
        },
      );
    } else {
      if (controller.prompts.isEmpty) {
        return const Center(
          child: Center(child: Text("正在加载prompts...")),
        );
      } else if (controller.prompts.isNotEmpty) {
        return PromptsView(controller.prompts.cast<Prompt>(), (value) {
          controller.textEditingController.text = value;
        });
      } else {
        return const Center(child: Text("加载prompts列表失败，请检查网络"));
      }
    }
  }
}
