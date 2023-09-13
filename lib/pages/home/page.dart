import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haina/pages/home/HomeWidget.dart';
import 'package:haina/pages/home/controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeWidget();
  }
}
