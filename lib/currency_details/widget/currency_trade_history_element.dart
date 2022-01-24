import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/currency_details/models/trade_history_type.dart';
import 'package:crypto_info/currency_details/models/trade_history_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CurrencyTradeHistoryElement extends StatelessWidget {
  const CurrencyTradeHistoryElement({
    required TradeHistoryUi element,
    Key? key,
  })  : _element = element,
        super(key: key);

  final TradeHistoryUi _element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              DateFormat('HH:mm').format(_element.date.toLocal()),
              style: AppTextStyles.bold.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(width: 4.sp),
          Expanded(
            flex: 2,
            child: Text(
              _element.rate,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular.copyWith(
                fontSize: 14.sp,
                color: _element.type == TradeHistoryType.buy
                    ? AppColors.priceRise
                    : AppColors.priceDrop,
              ),
            ),
          ),
          SizedBox(width: 4.sp),
          Expanded(
            flex: 2,
            child: Text(
              _element.amount,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.end,
              style: AppTextStyles.regular.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
