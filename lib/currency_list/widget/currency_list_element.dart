import 'package:crypto_info/common/routes.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/common/ui/widgets/currency_price.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyListElement extends StatelessWidget {
  const CurrencyListElement({
    required CurrencyUi currency,
    Key? key,
  })  : _currency = currency,
        super(key: key);

  final CurrencyUi _currency;

  void _onTap(BuildContext context) {
    Navigator.of(context)
        .pushNamed(Routes.currencyDetail, arguments: _currency);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => _onTap(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _currency.name,
                  style: AppTextStyles.bold.copyWith(fontSize: 14.sp),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  _currency.baseVolume,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: AppTextStyles.regular.copyWith(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(child: CurrencyPrice(currency: _currency)),
            ],
          ),
        ),
      ),
    );
  }
}
