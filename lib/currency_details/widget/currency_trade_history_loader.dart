import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CurrencyTradeHistoryLoader extends StatelessWidget {
  const CurrencyTradeHistoryLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.primary,
        highlightColor: AppColors.shimmerHighlight,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
