import 'package:crypto_info/common/ui/app_text_styles.dart';
import 'package:crypto_info/common/ui/gradient_container.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_bloc.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_state.dart';
import 'package:crypto_info/currency_list/widget/currency_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({Key? key}) : super(key: key);

  Widget _buildDivider() {
    return const Divider(
      height: 20,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }

  Widget _buildTitleForCurrencyList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Pair',
              style: AppTextStyles.boldTextStyle.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: Align(
              child: Text(
                'Volume',
                style: AppTextStyles.boldTextStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Price',
                style: AppTextStyles.boldTextStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyList() {
    return SafeArea(
      child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildTitleForCurrencyList(),
              _buildDivider(),
              Expanded(
                child: CurrencyList(currencies: state.currencies),
              ),
            ],
          );
        },
      ),
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
