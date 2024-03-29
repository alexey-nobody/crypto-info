import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static final _text = TextStyle(
    fontSize: 16.sp,
    fontStyle: FontStyle.normal,
    color: AppColors.textPrimary,
  );

  // Light
  static TextStyle light = _text.copyWith(
    fontWeight: FontWeight.w300,
  );

  // Regular
  static TextStyle regular = _text.copyWith(
    fontWeight: FontWeight.normal,
  );

  // Medium
  static TextStyle medium = _text.copyWith(
    fontWeight: FontWeight.w500,
  );

  // Bold
  static TextStyle bold = _text.copyWith(
    fontWeight: FontWeight.bold,
  );
}
