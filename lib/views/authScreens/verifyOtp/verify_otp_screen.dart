import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlab_assignment/config/app_font.dart';
import 'package:sowlab_assignment/config/app_utils.dart';
import 'package:sowlab_assignment/constants/enums.dart';

import '../../../customWidgets/custom_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

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
                    onTap: () => Get.offAllNamed('/login'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) => _buildOtpField()),
              ),
              SizedBox(height: 30.h),

              CustomButton(
                text: "Submit",
                onPressed: () => Get.toNamed('/reset-password'),
                backgroundColor: const Color(0xFFD67C65),
              ),
              SizedBox(height: 20.h),
              Center(
                child: TextButton(
                  onPressed: () {},
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

  Widget _buildOtpField() {
    return Container(
      width: 58.w,
      height: 58.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
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
