import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sowlab_assignment/config/app_font.dart';
import 'package:sowlab_assignment/constants/enums.dart';
import '../../config/app_utils.dart';
import '../../customWidgets/custom_button.dart';
import 'onboardingController/onboarding_controller.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    CustomScreenUtil.init(context);
    return Scaffold(
      body: Obx(() {
        final index = controller.currentIndex.value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: controller.bgColors[index],
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.images.length,
                  itemBuilder: (context, idx) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: SvgPicture.asset(
                        controller.images[idx],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.w),
                    topRight: Radius.circular(30.w),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.titles[index],
                      style: TextStyle(
                        fontFamily: AppFonts.beVietnam,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      controller.descriptions[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.beVietnam,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF261C12),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.images.length,
                        (idx) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 6.h,
                          width: index == idx ? 15.w : 6.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomButton(
                      text: "Join the movement!",
                      onPressed: () => Get.toNamed('/signup'),
                      backgroundColor: controller.bgColors[index],
                      width: 250.w,
                    ),

                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: controller.goToLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: AppFonts.beVietnam,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
