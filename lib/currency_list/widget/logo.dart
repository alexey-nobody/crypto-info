import 'package:crypto_info/common/ui/app_assets.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.3,
          child: Image.asset(AppAssets.logo, width: 64.sp),
        ),
        SizedBox(width: 16.sp),
        Text('CRYPTO', style: AppTextStyles.bold),
      ],
    );
  }
}
