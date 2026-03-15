import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sowlab_assignment/routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final newPasswordError = "".obs;
  final confirmPasswordError = "".obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  bool validate() {
    newPasswordError.value = "";
    confirmPasswordError.value = "";
    bool isValid = true;

    if (newPasswordController.text.isEmpty) {
      newPasswordError.value = "Password cannot be empty";
      isValid = false;
    } else if (newPasswordController.text.length < 6) {
      newPasswordError.value = "Password must be at least 6 characters";
      isValid = false;
    }

    if (confirmPasswordController.text != newPasswordController.text) {
      confirmPasswordError.value = "Passwords do not match";
      isValid = false;
    }

    return isValid;
  }

  Future<void> submitResetPassword() async {
    if (!validate()) return;

    try {
      isLoading.value = true;
      User? user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        await user.updatePassword(newPasswordController.text.trim());
        isLoading.value = false;
        Get.snackbar("Success", "Password changed successfully!", 
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(AppRoutes.login);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "User not authenticated. Please verify OTP again.", 
            backgroundColor: Colors.red, colorText: Colors.white);
        Get.offAllNamed(AppRoutes.forgotPassword);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Error updating password: ${e.toString()}", 
          backgroundColor: Colors.red, colorText: Colors.white);
      debugPrint("Password update error: $e");
    }
  }
}
