import 'package:get/get.dart';
import 'package:sowlab_assignment/routes/app_routes.dart';
import 'package:sowlab_assignment/views/authScreens/loginScreen/login_screen.dart';
import 'package:sowlab_assignment/views/authScreens/forgotPassword/forgot_password_screen.dart';
import 'package:sowlab_assignment/views/authScreens/resetPassword/reset_password_screen.dart';
import 'package:sowlab_assignment/views/authScreens/verifyOtp/verify_otp_screen.dart';
import 'package:sowlab_assignment/views/authScreens/signUpScreen/signup_screen.dart';
import 'package:sowlab_assignment/views/onboardingScreens/onboarding_view.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.onboard, page: () => const OnboardingView()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: AppRoutes.verifyOtp, page: () => const VerifyOtpScreen()),
    GetPage(name: AppRoutes.resetPassword, page: () => ResetPasswordScreen()),
  ];
}
