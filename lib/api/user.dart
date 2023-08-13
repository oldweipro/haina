import 'package:haina/model/conversation.dart';
import 'package:haina/model/user.dart';
import 'package:haina/util/http.dart';

/// 用户
class UserApi {
  /// 登录
  static Future<ConversationResponse> login({
    UserLoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/base/emailLogin',
      data: params?.toJson(),
    );
    return ConversationResponse.fromJson(response);
  }

  /// 注册
  static Future<UserRegisterRequestEntity> register({
    UserRegisterRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/user/register',
      data: params?.toJson(),
    );
    return UserRegisterRequestEntity.fromJson(response);
  }

  /// Profile
  static Future<UserLoginResponseEntity> profile() async {
    var response = await HttpUtil().post(
      '/user/profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// Logout
  static Future logout() async {
    return await HttpUtil().post(
      '/jwt/jsonInBlacklist',
    );
  }
}
