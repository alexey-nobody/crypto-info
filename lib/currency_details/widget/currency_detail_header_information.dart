import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/common/ui/widgets/currency_price.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyDetailHeaderInformation extends StatelessWidget {
  const CurrencyDetailHeaderInformation({
    required CurrencyUi currency,
    Key? key,
  })  : _currency = currency,
        super(key: key);

  final CurrencyUi _currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _currency.name,
            style: AppTextStyles.regular.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 12.sp),
          CurrencyPrice(
            currency: _currency,
            align: CurrencyPriceAlign.left,
          ),
        ],
      ),
    );
  }
}
