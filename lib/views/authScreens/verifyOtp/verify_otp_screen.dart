import 'package:flutter/material.dart';
import 'package:sowlab_assignment/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:sowlab_assignment/config/app_font.dart';
import 'package:sowlab_assignment/config/app_utils.dart';
import '../../../constants/enums.dart';
import '../authController/forgot_password_controller.dart';
import '../../../customWidgets/custom_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    CustomScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "FarmerEats",
                style: TextStyle(
                  fontFamily: AppFonts.beVietnam,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 80.h),
              Text(
                "Verify OTP",
                style: TextStyle(
                  fontFamily: AppFonts.beVietnam,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    "Remember your password? ",
                    style: TextStyle(
                      fontFamily: AppFonts.beVietnam,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.offAllNamed(AppRoutes.login),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: AppFonts.beVietnam,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFD67C65),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              
              // Timer Display
              Center(
                child: Obx(() => Text(
                  "00:${controller.timerSeconds.value.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontFamily: AppFonts.beVietnam,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: controller.timerSeconds.value < 10 ? Colors.red : Colors.black,
                  ),
                )),
              ),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) => _buildOtpField(controller, index)),
              ),
              
              Obx(() => controller.otpError.value.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Center(
                      child: Text(
                        controller.otpError.value,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  )
                : const SizedBox.shrink()),

              SizedBox(height: 30.h),

              CustomButton(
                text: "Submit",
                onPressed: () => controller.verifyOtp(),
                backgroundColor: const Color(0xFFD67C65),
              ),
              SizedBox(height: 20.h),
              
              Center(
                child: Column(
                  children: [
                    Text(
                      "API is not working, so OTP is here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.beVietnam,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Obx(() => Text(
                      "Demo OTP: ${controller.generatedOtp.value}",
                      style: TextStyle(
                        fontFamily: AppFonts.beVietnam,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFD67C65),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Center(
                child: TextButton(
                  onPressed: () => controller.resendOtp(),
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontFamily: AppFonts.beVietnam,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(ForgotPasswordController controller, int index) {
    return Container(
      width: 58.w,
      height: 58.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (val) => controller.onOtpChanged(val, index),
        style: TextStyle(
          fontFamily: AppFonts.beVietnam,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
