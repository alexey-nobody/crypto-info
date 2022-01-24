import 'package:crypto_info/common/routes_factory.dart';
import 'package:crypto_info/common/ui/app_assets.dart';
import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    String? title,
    Key? key,
  })  : _title = title,
        super(key: key);

  final String? _title;

  void _onTap(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesFactory.initialRoute,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () => _onTap(context),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 14.sp),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.backArrowButton,
                width: 30.sp,
                color: AppColors.normal,
              ),
              SizedBox(width: 16.sp),
              if (_title != null)
                Text(
                  _title!,
                  style: AppTextStyles.regular.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
