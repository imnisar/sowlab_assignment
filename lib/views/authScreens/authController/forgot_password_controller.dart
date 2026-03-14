import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPasswordController extends GetxController {
  final phoneController = TextEditingController();
  final otpControllers = List.generate(5, (_) => TextEditingController());
  final otpFocusNodes = List.generate(5, (_) => FocusNode());

  final timerSeconds = 30.obs;
  final generatedOtp = "".obs;
  final otpError = "".obs;
  final phoneError = "".obs;
  final isPhoneValid = false.obs;
  final isRegistered = false.obs;
  final isCheckingRegistration = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      validatePhone(phoneController.text);
    });
  }

  void validatePhone(String value) {
    final trimmedValue = value.replaceAll(' ', '');
    
    if (trimmedValue.isEmpty) {
      phoneError.value = "";
      isPhoneValid.value = false;
      isRegistered.value = false;
      return;
    }
    bool isIndiaOrPak = trimmedValue.startsWith("+91") || trimmedValue.startsWith("+92");
    bool isCorrectLength = trimmedValue.length == 13;
    bool isDigitsOnly = RegExp(r'^\+\d+$').hasMatch(trimmedValue);

    if (!isIndiaOrPak || !isCorrectLength || !isDigitsOnly) {
      phoneError.value = "Invalid phone number. Enter correct number with 10 digits after country code (+92 / +91). Extra digits are not allowed.";
      isPhoneValid.value = false;
      isRegistered.value = false;
    } else {
      phoneError.value = "";
      isPhoneValid.value = true;
      checkIfNumberRegistered(trimmedValue);
    }
  }

  Future<void> checkIfNumberRegistered(String phone) async {
    try {
      isCheckingRegistration.value = true;
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phone)
          .get();

      if (query.docs.isEmpty) {
        phoneError.value = "This number is not registered. Please enter the number used at signup.";
        isRegistered.value = false;
      } else {
        phoneError.value = "";
        isRegistered.value = true;
      }
    } catch (e) {
      debugPrint("Registration check error: $e");
    } finally {
      isCheckingRegistration.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void generateNewOtp() {
    final random = Random();
    generatedOtp.value = (10000 + random.nextInt(90000)).toString();
    debugPrint("Generated OTP: ${generatedOtp.value}");
  }

  void startTimer() {
    _timer?.cancel();
    timerSeconds.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
        autoRegenerateOtp();
      }
    });
  }

  void autoRegenerateOtp() {
    generateNewOtp();
    startTimer();
  }

  void sendOtp() {
    if (phoneController.text.isNotEmpty) {
      generateNewOtp();
      startTimer();
      Get.toNamed('/verify-otp');
    } else {
      Get.snackbar("Error", "Please enter your phone number", 
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void resendOtp() {
    generateNewOtp();
    startTimer();
  }

  void verifyOtp() {
    String enteredOtp = otpControllers.map((c) => c.text).join();
    if (enteredOtp == generatedOtp.value) {
      otpError.value = "";
      _timer?.cancel();
      Get.toNamed('/reset-password');
    } else {
      otpError.value = "Incorrect OTP, try again";
    }
  }

  void onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 4) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
    
    if (otpControllers.every((c) => c.text.isNotEmpty)) {
      verifyOtp();
    }
  }
}
