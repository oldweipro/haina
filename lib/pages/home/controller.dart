import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:haina/pages/home/state.dart';

class HomeController extends GetxController {
  HomeController();

  final state = HomeState();
  final animationController = AnimationController(
    duration: Duration(milliseconds: transitionLength.toInt() * 2),
    value: 0,
    vsync: this,
  );
  final railAnimation = CurvedAnimation(
    parent: controller,
    curve: const Interval(0.5, 1.0),
  );

  @override
  void dispose() {
    animationController.dispose();
    passController.dispose();
    super.dispose();
  }
}
