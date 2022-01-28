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

  Widget _buildInformation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price',
              style: AppTextStyles.bold,
            ),
            Text(
              'Volume (${_currency.name.split('/')[1]})',
              style: AppTextStyles.bold,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CurrencyPrice(
              currency: _currency,
              align: CurrencyPriceAlign.left,
            ),
            Text(
              _currency.baseVolume,
              style: AppTextStyles.regular,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: _buildInformation(),
    );
  }
}
