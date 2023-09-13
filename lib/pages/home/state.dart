import 'package:get/get.dart';

class HomeState {
  Rx<bool> controllerInitialized = false.obs;
  // 中等布局
  Rx<bool> showMediumSizeLayout = false.obs;
  // 大尺寸，也就是说，这个是控制桌面端的，const double largeWidthBreakpoint = 1300;
  Rx<bool> showLargeSizeLayout = false.obs;
  // 这是主页默认值
  Rx<int> screenIndex = 0.obs;
}
