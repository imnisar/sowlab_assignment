import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_font.dart';
import '../../../config/app_images.dart';
import '../../../config/app_utils.dart';
import '../../../constants/enums.dart';
import '../../../customWidgets/custom_button.dart';
import '../../../customWidgets/custom_text_field.dart';
import '../authController/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    CustomScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          switch (controller.currentStep.value) {
            case 1:
              return _buildStepOne(controller);
            case 2:
              return _buildStepTwo(controller);
            case 3:
              return _buildStepThree(controller);
            case 4:
              return _buildStepFour(controller);
            default:
              return _buildStepOne(controller);
          }
        }),
      ),
    );
  }

  Widget _buildStepOne(SignupController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "FarmerEats",
            style: TextStyle(fontFamily: AppFonts.beVietnam, fontSize: 16),
          ),
          SizedBox(height: 30.h),
          Text(
            "Signup 1 of 4",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Welcome!",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _socialBtn(AppImages.google),
              _socialBtn(AppImages.appleLogo),
              _socialBtn(AppImages.facebook),
            ],
          ),
          SizedBox(height: 30.h),
          Center(
            child: Text(
              "or signup with",
              style: TextStyle(
                fontFamily: AppFonts.beVietnam,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            controller: controller.nameController,
            hintText: "Full Name",
            icon: AppImages.person,
            errorMsg: controller.nameError,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.emailController,
            hintText: "Email Address",
            icon: AppImages.icEmail,
            errorMsg: controller.emailError,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.phoneController,
            hintText: "Phone Number",
            icon: AppImages.phone,
            errorMsg: controller.phoneError,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.passwordController,
            hintText: "Password",
            icon: AppImages.lock,
            isPassword: true,
            errorMsg: controller.passwordError,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.confirmPasswordController,
            hintText: "Re-enter Password",
            icon: AppImages.lock,
            isPassword: true,
            errorMsg: controller.confirmPasswordError,
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              CustomButton(
                text: "Continue",
                onPressed: controller.nextStep,
                backgroundColor: const Color(0xFFD67C65),
                width: 180.w,
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildStepTwo(SignupController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "FarmerEats",
            style: TextStyle(fontFamily: AppFonts.beVietnam, fontSize: 16),
          ),
          SizedBox(height: 30.h),
          Text(
            "Signup 2 de 4",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Farm Info",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.h),
          CustomTextField(
            controller: controller.businessNameController,
            hintText: "Business Name",
            icon: AppImages.icTag,
            errorMsg: controller.businessNameError,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.informalNameController,
            hintText: "Informal Name",
            icon: AppImages.icUser,
            errorMsg: controller.informalNameError,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.addressController,
            hintText: "Street Address",
            icon: AppImages.icHome,
            errorMsg: controller.addressError,
          ),
          SizedBox(height: 15.h),
          CustomTextField(
            controller: controller.cityController,
            hintText: "City",
            icon: AppImages.icLocation,
            errorMsg: controller.cityError,
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedState.value,
                        items: ['State', 'FL', 'NY', 'CA'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: AppFonts.beVietnam,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            controller.selectedState.value = val!,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                flex: 3,
                child: CustomTextField(
                  controller: controller.zipController,
                  hintText: "Enter Zipcode",
                  icon: "",
                  errorMsg: controller.zipError,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 80.h),
          Row(
            children: [
              IconButton(
                onPressed: controller.previousStep,
                icon: Icon(Icons.arrow_back),
              ),
              Spacer(),
              CustomButton(
                text: "Continue",
                onPressed: controller.nextStep,
                backgroundColor: const Color(0xFFD67C65),
                width: 180.w,
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildStepThree(SignupController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "FarmerEats",
            style: TextStyle(fontFamily: AppFonts.beVietnam, fontSize: 16),
          ),
          SizedBox(height: 30.h),
          Text(
            "Signup 3 de 4",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Verification",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Attach proof of registration",
                style: TextStyle(fontFamily: AppFonts.beVietnam, fontSize: 14),
              ),
              IconButton(
                onPressed: controller.attachFile,
                icon: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD67C65),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Obx(
            () => controller.attachedFileName.value.isNotEmpty
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Row(
                      children: [
                        Text(
                          controller.attachedFileName.value,
                          style: TextStyle(
                            fontFamily: AppFonts.beVietnam,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: controller.removeFile,
                          icon: Icon(Icons.close, size: 20),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: controller.previousStep,
                icon: Icon(Icons.arrow_back),
              ),
              Spacer(),
              CustomButton(
                text: controller.attachedFileName.value.isEmpty
                    ? "Continue"
                    : "Submit",
                onPressed: controller.nextStep,
                backgroundColor: const Color(0xFFD67C65),
                width: 180.w,
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildStepFour(SignupController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "FarmerEats",
            style: TextStyle(fontFamily: AppFonts.beVietnam, fontSize: 16),
          ),
          SizedBox(height: 30.h),
          Text(
            "Signup 4 de 4",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Business Hours",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Choose the hours your farm is open for pickups. This will allow customers to order deliveries.",
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.days
                .map(
                  (day) => Obx(() {
                    final isSelected = controller.selectedDays.contains(day);
                    return GestureDetector(
                      onTap: () => controller.toggleDay(day),
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD67C65)
                              : const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(8.w),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          day,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }),
                )
                .toList(),
          ),
          SizedBox(height: 30.h),
          Wrap(
            spacing: 15.w,
            runSpacing: 15.h,
            children: controller.timeSlots
                .map(
                  (slot) => Obx(() {
                    final isSelected = controller.selectedTimeSlots.contains(
                      slot,
                    );
                    return GestureDetector(
                      onTap: () => controller.toggleTimeSlot(slot),
                      child: Container(
                        width: 160.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF8C569)
                              : const Color(0xFF261C12).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Text(
                          slot,
                          style: TextStyle(
                            fontFamily: AppFonts.beVietnam,
                            fontSize: 14,
                            color: const Color(0xFF261C12),
                          ),
                        ),
                      ),
                    );
                  }),
                )
                .toList(),
          ),
          Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: controller.previousStep,
                icon: Icon(Icons.arrow_back),
              ),
              Spacer(),
              Obx(() => CustomButton(
                text: controller.isLoading.value ? "" : "Signup",
                onPressed: controller.isLoading.value ? null : controller.signup,
                backgroundColor: const Color(0xFFD67C65),
                width: 180.w,
                child: controller.isLoading.value 
                    ? const SizedBox(
                        height: 20, 
                        width: 20, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      ) 
                    : null,
              )),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _socialBtn(String icon) {
    return Container(
      width: 90.w,
      height: 52.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(30.w),
      ),
      padding: EdgeInsets.all(12.w),
      child: SvgPicture.asset(icon, fit: BoxFit.contain),
    );
  }
}
