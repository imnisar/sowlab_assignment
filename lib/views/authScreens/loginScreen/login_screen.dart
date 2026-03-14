import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../config/app_font.dart';
import '../../../config/app_images.dart';
import '../../../config/app_utils.dart';
import '../../../constants/enums.dart';
import '../../../customWidgets/custom_text_field.dart';
import '../../../customWidgets/custom_button.dart';
import '../authController/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                "Welcome back!",
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
                    "New here? ",
                    style: TextStyle(
                      fontFamily: AppFonts.beVietnam,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: controller.goToSignUp,
                    child: Text(
                      "Create account",
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
                controller: controller.emailController,
                hintText: "Email Address",
                icon: AppImages.icEmail,
                errorMsg: controller.emailError,
              ),
              SizedBox(height: 20.h),

              CustomTextField(
                controller: controller.passwordController,
                hintText: "Password",
                icon: AppImages.lock,
                isPassword: true,
                errorMsg: controller.passwordError,
                suffix: InkWell(
                  onTap: controller.forgotPassword,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Text(
                      "Forgot?",
                      style: TextStyle(
                        fontFamily: AppFonts.beVietnam,
                        fontSize: 14,
                        color: const Color(0xFFD67C65),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => AnimatedOpacity(
                opacity: controller.generalError.value.isNotEmpty ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    controller.generalError.value,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: AppFonts.beVietnam,
                    ),
                  ),
                ),
              )),
              SizedBox(height: 30.h),
              Obx(() => CustomButton(
                text: controller.isLoading.value ? "" : "Login",
                onPressed: controller.isLoading.value ? null : () => controller.login(),
                backgroundColor: const Color(0xFFD67C65),
                child: controller.isLoading.value 
                    ? const SizedBox(
                        height: 20, 
                        width: 20, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      ) 
                    : null,
              )),

              SizedBox(height: 40.h),
              Center(
                child: Text(
                  "or login with",
                  style: TextStyle(
                    fontFamily: AppFonts.beVietnam,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialButton(AppImages.google),
                  _buildSocialButton(AppImages.appleLogo),
                  _buildSocialButton(AppImages.facebook),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String icon) {
    return Container(
      width: 90.w,
      height: 52.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(30.w),
      ),
      padding: EdgeInsets.all(12.w),
      child: SvgPicture.asset(icon, fit: BoxFit.contain),
    );
  }
}
