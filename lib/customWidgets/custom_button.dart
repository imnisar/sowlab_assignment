import 'package:flutter/material.dart';
import '../config/app_font.dart';
import '../constants/enums.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.width,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          minimumSize: Size(width ?? double.infinity, height ?? 60.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        child: child ?? Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.beVietnam,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
