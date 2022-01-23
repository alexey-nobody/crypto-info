import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';

class CurrencyPrice extends StatelessWidget {
  const CurrencyPrice({
    required CurrencyUi currency,
    CurrencyPriceAlign align = CurrencyPriceAlign.right,
    Key? key,
  })  : _currency = currency,
        _align = align,
        super(key: key);

  final CurrencyUi _currency;
  final CurrencyPriceAlign _align;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: _align == CurrencyPriceAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          _currency.price,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: AppTextStyles.regular,
        ),
        Row(
          mainAxisAlignment: _align == CurrencyPriceAlign.left
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Text(
              _currency.percentChange,
              style: AppTextStyles.regular.copyWith(
                color: _currency.priceState == CurrencyUiPriceState.rise
                    ? AppColors.priceRise
                    : AppColors.priceDrop,
              ),
            ),
            _currency.priceState == CurrencyUiPriceState.rise
                ? const Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.priceRise,
                  )
                : const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.priceDrop,
                  ),
          ],
        ),
      ],
    );
  }
}

enum CurrencyPriceAlign { left, right }
