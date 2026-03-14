import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlab_assignment/views/authScreens/loginScreen/login_screen.dart';
import 'package:sowlab_assignment/views/authScreens/forgotPassword/forgot_password_screen.dart';
import 'package:sowlab_assignment/views/authScreens/resetPassword/reset_password_screen.dart';
import 'package:sowlab_assignment/views/authScreens/verifyOtp/verify_otp_screen.dart';
import 'package:sowlab_assignment/views/authScreens/signUpScreen/signup_screen.dart';
import 'package:sowlab_assignment/views/onboardingScreens/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmerEats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD67C65)),
        useMaterial3: true,
      ),
      initialRoute: '/onboard',
      getPages: [
        GetPage(name: '/onboard', page: () => const OnboardingView()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/forgot-password', page: () =>  ForgotPasswordScreen()),
        GetPage(name: '/verify-otp', page: () => const VerifyOtpScreen()),
        GetPage(name: '/reset-password', page: () =>  ResetPasswordScreen()),
      ],
    );
  }
}
