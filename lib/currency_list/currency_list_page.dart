import 'package:crypto_info/common/ui/app_colors.dart';
import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/common/ui/gradient_container.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_bloc.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_state.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({Key? key}) : super(key: key);

  Widget _buildCurrencyList() {
    return BlocBuilder<CurrencyListBloc, CurrencyListState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.currencies.length,
          itemBuilder: (context, index) {
            final currency = state.currencies[index];

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      currency.name,
                      style: AppTextStyles.boldTextStyle,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      child: Text(
                        currency.baseVolume,
                        style: AppTextStyles.lightTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currency.price,
                          style: AppTextStyles.mediumTextStyle,
                        ),
                        Text(
                          currency.percentChange,
                          style: AppTextStyles.regularTextStyle.copyWith(
                            color:
                                currency.priceState == CurrencyUiPriceState.rise
                                    ? AppColors.priceRise
                                    : AppColors.priceDrop,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          _buildCurrencyList(),
        ],
      ),
    );
  }
}
