import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_font.dart';
import '../../../config/app_images.dart';
import '../../../config/app_utils.dart';
import '../../../constants/enums.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
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
                "Forgot Password?",
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
                    onTap: () => Get.back(),
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

              CustomTextField(
                controller: phoneController,
                hintText: "Phone Number",
                icon: AppImages.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                text: "Send Code",
                onPressed: () => Get.toNamed('/verify-otp'),
                backgroundColor: const Color(0xFFD5715B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
