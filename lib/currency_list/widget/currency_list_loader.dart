import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CurrencyListLoader extends StatelessWidget {
  const CurrencyListLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Shimmer.fromColors(
          baseColor: AppColors.primary,
          highlightColor: AppColors.shimmerHighlight,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 60.h,
          ),
        ),
      ),
    );
  }
}
