import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({
    required List<CurrencyUi> currencies,
    Key? key,
  })  : _currencies = currencies,
        super(key: key);

  final List<CurrencyUi> _currencies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _currencies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _currencies[index].name,
                style: AppTextStyles.regularTextStyle,
              ),
            ),
            Expanded(
              child: Align(
                child: Text(
                  _currencies[index].baseVolume,
                  style: AppTextStyles.regularTextStyle,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _currencies[index].price,
                    style: AppTextStyles.regularTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _currencies[index].percentChange,
                        style: AppTextStyles.regularTextStyle.copyWith(
                          color: _currencies[index].priceState ==
                                  CurrencyUiPriceState.rise
                              ? AppColors.priceRise
                              : AppColors.priceDrop,
                        ),
                      ),
                      _currencies[index].priceState == CurrencyUiPriceState.rise
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
      ),
    );
  }
}
