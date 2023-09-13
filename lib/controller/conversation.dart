import 'package:get/get.dart';
import 'package:haina/api/conversation.dart';
import 'package:haina/model/conversation.dart';
import 'package:haina/model/response_result.dart';

class ConversationController extends GetxController {
  final conversationList = <Conversation>[].obs;

  final currentConversationUuid = "".obs;

  static ConversationController get to => Get.find();

  @override
  void onInit() async {
    ConversationRequest request = ConversationRequest(conversationType: 0);
    // HainaResponse response =
    //     await ConversationApi.getCurrentUserConversationList(params: request);
    conversationList.value = await ConversationRepository().getConversations();
    super.onInit();
  }

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
