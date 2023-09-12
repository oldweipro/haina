import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/common/router/observers.dart';
import 'package:haina/common/router/router.dart';
import 'package:haina/component/chat.dart';
import 'package:haina/pages/chat/binding.dart';
import 'package:haina/pages/chat/page.dart';
import 'package:haina/pages/home/page.dart';
import 'package:haina/pages/setting/binding.dart';
import 'package:haina/pages/setting/page.dart';
import 'package:haina/pages/sign_in/bindings.dart';
import 'package:haina/pages/sign_in/page.dart';
import 'package:haina/pages/unknown/index.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 免登陆
    GetPage(
      name: AppRoutes.initial,
      page: () => const HomePage(),
      // binding: HomeBinding(),
      // middlewares: [
      //   RouteWelcomeMiddleware(priority: 1),
      // ],
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.SIGN_UP,
    //   page: () => SignUpPage(),
    //   binding: SignUpBinding(),
    // ),
    //
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
      // middlewares: [
      //   RouteAuthMiddleware(priority: 1),
      // ],
    ),
    GetPage(
      name: AppRoutes.chatOld,
      page: () => const ChatWindow(),
    ),
    //
    // 分类列表
    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const UnknownPage(),
  );
}
