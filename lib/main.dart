import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haina/common/configs/translations.dart';
import 'package:haina/controller/controller.dart';
import 'package:haina/pages/home/controller.dart';
import 'package:haina/pages/setting/controller.dart';
import 'package:haina/common/router/page.dart';
import 'package:haina/common/router/router.dart';
import 'package:haina/common/service/service.dart';
import 'package:haina/common/store/store.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ConversationController());
    Get.put(MessageController());
    Get.put(PromptController());
    Get.put(SettingController());
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: '海纳AI',
            initialRoute: AppRoutes.initial,
            getPages: AppPages.routes,
            unknownRoute: AppPages.unknownRoute,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            themeMode: ThemeMode.system,
            locale: const Locale('zh'),
            translations: MyTranslations(),
            builder: EasyLoading.init(),
            navigatorObservers: [AppPages.observer],
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
