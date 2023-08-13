import 'package:haina/model/conversation.dart';
import 'package:haina/util/http.dart';

class ConversationApi {
  /// 获取分页列表
  static Future<ConversationResponse> getCurrentUserConversationList({
    ConversationRequest? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/conversation/getCurrentUserConversationList',
      queryParameters: params?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
    );
    return ConversationResponse.fromJson(response);
  }
}
