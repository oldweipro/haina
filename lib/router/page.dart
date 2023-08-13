import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/pages/login/page.dart';
import 'package:haina/pages/new/page.dart';
import 'package:haina/pages/setting/binding.dart';
import 'package:haina/pages/setting/page.dart';
import 'package:haina/pages/unknown/index.dart';
import 'package:haina/router/observers.dart';
import 'package:haina/router/router.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // 免登陆
    GetPage(
      name: AppRoutes.initial,
      page: () => NewPage(),
      // binding: HomeBinding(),
      // middlewares: [
      //   RouteWelcomeMiddleware(priority: 1),
      // ],
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
    ),
    // GetPage(
    //   name: AppRoutes.SIGN_UP,
    //   page: () => SignUpPage(),
    //   binding: SignUpBinding(),
    // ),
    //
    // // 需要登录
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),
    //
    // 分类列表
    GetPage(
      name: AppRoutes.setting,
      page: () => SettingPage(),
      binding: SettingBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const UnknownPage(),
  );
}
