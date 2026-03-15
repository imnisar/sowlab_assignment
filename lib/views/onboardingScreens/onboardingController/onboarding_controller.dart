import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_images.dart';
import 'package:sowlab_assignment/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentIndex = 0.obs;

  final List<String> images = [
    AppImages.quality,
    AppImages.convenientBg,
    AppImages.localBg,
  ];

  final List<String> titles = ["Quality", "Convenient", "Local"];

  final List<String> descriptions = [
    "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain.",
    "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.",
    "We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time."
  ];

  final List<Color> bgColors = [
    const Color(0xFF5EA25F),
    const Color(0xFFD67C65),
    const Color(0xFFF7C978),
  ];

  void onPageChanged(int index) => currentIndex.value = index;

  void goToLogin() => Get.offNamed(AppRoutes.login);
}