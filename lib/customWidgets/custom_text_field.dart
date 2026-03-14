import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../config/app_font.dart';
import '../constants/enums.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final bool isPassword;
  final Widget? suffix;
  final RxString? errorMsg;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.suffix,
    this.errorMsg,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            style: TextStyle(
              fontFamily: AppFonts.beVietnam,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 18.h),
              prefixIcon: Padding(
                padding: EdgeInsets.all(15.w),
                  child: SvgPicture.asset(
              icon,
              width: 20.w,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
              ),
              suffixIcon: suffix,
              border: InputBorder.none,
              suffixIconConstraints: BoxConstraints(minHeight: 14.h),
            ),
          ),
        ),
        if (errorMsg != null)
          Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: errorMsg!.value.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 5.w),
                    child: Text(
                      errorMsg!.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: AppFonts.beVietnam,
                      ),
                    ),
                  ),
          )),
      ],
    );
  }
}
