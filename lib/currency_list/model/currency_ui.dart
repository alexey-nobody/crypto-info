import 'package:crypto_info/currency_list/model/currency_data_response.dart';
import 'package:equatable/equatable.dart';

enum CurrencyUiPriceState { drop, rise }

class CurrencyUi extends Equatable {
  const CurrencyUi({
    required this.id,
    required this.currencyPair,
    required this.name,
    required this.price,
    required this.baseVolume,
    required this.percentChange,
    required this.priceState,
  });

  factory CurrencyUi.fromResponse({
    required String currencyPair,
    required CurrencyDataResponse response,
  }) {
    final trailingZerosRegExp = RegExp(r'([.]*0+)(?!.*\d)');

    return CurrencyUi(
      id: response.id,
      currencyPair: currencyPair,
      name: currencyPair.split('_').reversed.join('/'),
      price:
          response.last.toStringAsFixed(7).replaceAll(trailingZerosRegExp, ''),
      baseVolume: response.baseVolume.toStringAsFixed(0),
      percentChange: (response.percentChange * 100)
          .toStringAsFixed(2)
          .replaceAll(trailingZerosRegExp, ''),
      priceState: response.percentChange > 0
          ? CurrencyUiPriceState.rise
          : CurrencyUiPriceState.drop,
    );
  }

  final int id;
  final String currencyPair;
  final String name;
  final String price;
  final String baseVolume;
  final String percentChange;
  final CurrencyUiPriceState priceState;

  @override
  List<Object?> get props => [
        id,
        currencyPair,
        name,
        price,
        baseVolume,
        percentChange,
        priceState,
      ];
}
