import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyTradeHistoryTitle extends StatelessWidget {
  const CurrencyTradeHistoryTitle({
    required CurrencyUi currency,
    Key? key,
  })  : _currency = currency,
        super(key: key);

  final CurrencyUi _currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Trade history',
            style: AppTextStyles.bold,
          ),
          SizedBox(height: 32.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Time',
                  style: AppTextStyles.bold.copyWith(fontSize: 14.sp),
                ),
              ),
              SizedBox(width: 4.sp),
              Expanded(
                flex: 2,
                child: Text(
                  'Rate (${_currency.name.split('/')[1]})',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold.copyWith(fontSize: 14.sp),
                ),
              ),
              SizedBox(width: 4.sp),
              Expanded(
                flex: 2,
                child: Text(
                  'Amount (${_currency.name.split('/')[0]})',
                  textAlign: TextAlign.end,
                  style: AppTextStyles.bold.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
        ],
      ),
    );
  }
}
