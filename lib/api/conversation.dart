import 'package:haina/model/conversation.dart';
import 'package:haina/common/util/http.dart';

class ConversationApi {
  /// 获取分页列表
  static Future<HainaResponse> getCurrentUserConversationList({
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
    return HainaResponse.fromJson(response);
  }

  /// 获取分页列表
  static Future<HainaResponse> getProductList({
    ConversationRequest? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      '/product/getProductList?page=1&pageSize=10',
      queryParameters: params?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
    );
    return HainaResponse.fromJson(response);
  }
}
