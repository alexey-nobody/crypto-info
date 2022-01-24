import 'package:crypto_info/common/routes_factory.dart';
import 'package:crypto_info/common/ui/app_assets.dart';
import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    Key? key,
  }) : super(key: key);

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
          child: SvgPicture.asset(
            AppAssets.backArrowButton,
            width: 30.sp,
            color: AppColors.normal,
          ),
        ),
      ),
    );
  }
}
