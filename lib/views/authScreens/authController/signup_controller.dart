import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final currentStep = 1.obs;
  final isLoading = false.obs;
  final isSignupComplete = false.obs;
  final isImagePicked = false.obs;
  final Rx<File?> pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameError = RxString('');
  final emailError = RxString('');
  final phoneError = RxString('');
  final isPhoneValid = false.obs;
  final passwordError = RxString('');
  final confirmPasswordError = RxString('');

  final businessNameController = TextEditingController();
  final informalNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final selectedState = RxString('State');

  final businessNameError = RxString('');
  final informalNameError = RxString('');
  final addressError = RxString('');
  final cityError = RxString('');
  final zipError = RxString('');

  final attachedFileName = RxString('');

  final selectedDays = <String>[].obs;
  final selectedTimeSlots = <String>[].obs;

  final days = ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'];
  final timeSlots = [
    '8:00am - 10:00am',
    '10:00am - 1:00pm',
    '1:00pm - 4:00pm',
    '4:00pm - 7:00pm',
    '7:00pm - 10:00pm'
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      validatePhoneField(phoneController.text);
    });
  }

  void validatePhoneField(String value) {
    final trimmedValue = value.replaceAll(' ', '');
    
    if (trimmedValue.isEmpty) {
      phoneError.value = "";
      isPhoneValid.value = false;
      return;
    }
    bool isIndiaOrPak = trimmedValue.startsWith("+91") || trimmedValue.startsWith("+92");
    bool isCorrectLength = trimmedValue.length == 13;
    bool isDigitsOnly = RegExp(r'^\+\d+$').hasMatch(trimmedValue);

    if (!isIndiaOrPak || !isCorrectLength || !isDigitsOnly) {
      phoneError.value = "Invalid phone number. Enter correct number with 10 digits after country code (+92 / +91). Extra digits are not allowed.";
      isPhoneValid.value = false;
    } else {
      phoneError.value = "";
      isPhoneValid.value = true;
    }
  }

  void nextStep() {
    if (currentStep.value < 4) {
      if (validateCurrentStep()) {
        currentStep.value++;
      }
    } else {
      signup();
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  bool validateCurrentStep() {
    if (currentStep.value == 1) {
      return validateStepOne();
    } else if (currentStep.value == 2) {
      return validateStepTwo();
    }
    return true;
  }

  bool validateStepOne() {
    nameError.value = '';
    emailError.value = '';
    phoneError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';

    bool isValid = true;
    if (nameController.text.isEmpty) {
      nameError.value = 'Full Name is required';
      isValid = false;
    }
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    }
    if (phoneController.text.isEmpty) {
      phoneError.value = 'Phone number is required';
      isValid = false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }
    return isValid;
  }

  bool validateStepTwo() {
    businessNameError.value = '';
    informalNameError.value = '';
    addressError.value = '';
    cityError.value = '';
    zipError.value = '';

    bool isValid = true;
    if (businessNameController.text.isEmpty) {
      businessNameError.value = 'Business Name is required';
      isValid = false;
    }
    if (informalNameController.text.isEmpty) {
      informalNameError.value = 'Informal Name is required';
      isValid = false;
    }
    if (addressController.text.isEmpty) {
      addressError.value = 'Address is required';
      isValid = false;
    }
    if (cityController.text.isEmpty) {
      cityError.value = 'City is required';
      isValid = false;
    }
    if (selectedState.value == 'State') {
      zipError.value = 'Please select a state';
      isValid = false;
    }
    if (zipController.text.isEmpty) {
      zipError.value = 'Zip code is required';
      isValid = false;
    }
    return isValid;
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  void toggleTimeSlot(String slot) {
    if (selectedTimeSlots.contains(slot)) {
      selectedTimeSlots.remove(slot);
    } else {
      selectedTimeSlots.add(slot);
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
      attachedFileName.value = image.name;
      isImagePicked.value = true;
    }
  }

  void removeFile() {
    pickedImage.value = null;
    attachedFileName.value = '';
    isImagePicked.value = false;
  }

  Future<void> signup() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'fullName': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'farmInfo': {
          'businessName': businessNameController.text.trim(),
          'informalName': informalNameController.text.trim(),
          'address': addressController.text.trim(),
          'city': cityController.text.trim(),
          'state': selectedState.value,
          'zipCode': zipController.text.trim(),
        },
        'verificationFile': attachedFileName.value,
        'imagePath': pickedImage.value?.path ?? "",
        'businessHours': {
          'selectedDays': selectedDays.toList(),
          'selectedTimeSlots': selectedTimeSlots.toList(),
        },
        'createdAt': FieldValue.serverTimestamp(),
      });

      isLoading.value = false;
      isSignupComplete.value = true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = "An error occurred";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      Get.snackbar("Error", message, backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong. Please try again.", backgroundColor: Colors.red, colorText: Colors.white);
      debugPrint("Signup error: $e");
    }
  }
}
