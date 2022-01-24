import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:crypto_info/currency_list/widget/currency_list_element.dart';
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
      itemBuilder: (context, index) => CurrencyListElement(
        currency: _currencies[index],
      ),
    );
  }
}
