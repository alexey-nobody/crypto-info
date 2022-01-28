import 'package:crypto_info/common/ui/widgets/back_arrow_button.dart';
import 'package:crypto_info/common/ui/widgets/gradient_container.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_bloc.dart';
import 'package:crypto_info/currency_details/bloc/currency_detail_state.dart';
import 'package:crypto_info/currency_details/widget/currency_chart.dart';
import 'package:crypto_info/currency_details/widget/currency_chart_loader.dart';
import 'package:crypto_info/currency_details/widget/currency_detail_header_information.dart';
import 'package:crypto_info/currency_details/widget/currency_trade_history_list.dart';
import 'package:crypto_info/currency_details/widget/currency_trade_history_loader.dart';
import 'package:crypto_info/currency_details/widget/currency_trade_history_title.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyDetailPage extends StatelessWidget {
  const CurrencyDetailPage({
    required CurrencyUi currency,
    Key? key,
  })  : _currency = currency,
        super(key: key);

  final CurrencyUi _currency;

  Widget _buildCurrencyChart() {
    return BlocBuilder<CurrencyDetailBloc, CurrencyDetailState>(
      builder: (context, state) =>
          state.status == CurrencyDetailStateStatus.loaded
              ? CurrencyChart(spots: state.spots)
              : const CurrencyChartLoader(),
    );
  }

  Widget _buildTradeHistory() {
    return Column(
      children: [
        CurrencyTradeHistoryTitle(currency: _currency),
        BlocBuilder<CurrencyDetailBloc, CurrencyDetailState>(
          builder: (context, state) =>
              state.status == CurrencyDetailStateStatus.loaded
                  ? Expanded(
                      child: CurrencyTradeHistoryList(
                        tradeHistory: state.tradeHistory,
                      ),
                    )
                  : const CurrencyTradeHistoryLoader(),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          BackArrowButton(title: _currency.name),
          CurrencyDetailHeaderInformation(currency: _currency),
          SizedBox(height: 32.h),
          _buildCurrencyChart(),
          SizedBox(height: 32.h),
          Expanded(child: _buildTradeHistory()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientContainer(),
          _buildBody(context),
        ],
      ),
    );
  }
}
