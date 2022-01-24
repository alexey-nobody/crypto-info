import 'package:crypto_info/currency_details/models/trade_history_ui.dart';
import 'package:crypto_info/currency_details/widget/currency_trade_history_element.dart';
import 'package:flutter/material.dart';

class CurrencyTradeHistoryList extends StatelessWidget {
  const CurrencyTradeHistoryList({
    required List<TradeHistoryUi> tradeHistory,
    Key? key,
  })  : _tradeHistory = tradeHistory,
        super(key: key);

  final List<TradeHistoryUi> _tradeHistory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tradeHistory.length,
      itemBuilder: (context, index) => CurrencyTradeHistoryElement(
        element: _tradeHistory[index],
      ),
    );
  }
}
