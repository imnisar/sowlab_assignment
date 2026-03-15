import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlab_assignment/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailError = RxString('');
  final passwordError = RxString('');
  final generalError = RxString('');
  final isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (isLoading.value) return;

    emailError.value = '';
    passwordError.value = '';
    generalError.value = '';

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    bool isValid = true;

    if (email.isEmpty) {
      emailError.value = 'Email address cannot be empty';
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email address';
      isValid = false;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password cannot be empty';
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (!isValid) return;

    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      
      Get.snackbar("Success", "Login Successful", backgroundColor: Colors.green, colorText: Colors.white);
      // Get.offAllNamed('/home'); // Assuming home route exists or path to next screen
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        generalError.value = 'User not registered yet';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        generalError.value = 'Incorrect email or password';
      } else if (e.code == 'invalid-email') {
        emailError.value = 'The email address is badly formatted.';
      } else {
        generalError.value = e.message ?? 'An unknown error occurred';
      }
    } catch (e) {
      isLoading.value = false;
      generalError.value = 'Something went wrong. Please try again.';
      debugPrint("Login error: $e");
    }
  }

  void goToSignUp() {
    Get.toNamed(AppRoutes.signup);
  }

  void forgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
}
