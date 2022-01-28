import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CurrencyChartLoader extends StatelessWidget {
  const CurrencyChartLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primary,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 160.h,
      ),
    );
  }
}
