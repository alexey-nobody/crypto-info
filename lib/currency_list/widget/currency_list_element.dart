import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';

class CurrencyListElement extends StatelessWidget {
  const CurrencyListElement({
    required CurrencyUi currency,
    Key? key,
  })  : _currency = currency,
        super(key: key);

  final CurrencyUi _currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(_currency.name, style: AppTextStyles.regular)),
          Expanded(
            child: Align(
              child: Text(
                _currency.baseVolume,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: AppTextStyles.regular,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _currency.price,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: AppTextStyles.regular,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
            ),
          ),
        ],
      ),
    );
  }
}
