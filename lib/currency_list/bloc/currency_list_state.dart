import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:equatable/equatable.dart';

enum CurrencyListStateStatus { initial, loading, loaded }

class CurrencyListState extends Equatable {
  const CurrencyListState._({
    required this.status,
    this.currencies = const [],
  });

  const CurrencyListState.loading()
      : this._(status: CurrencyListStateStatus.loading);

  const CurrencyListState.loaded({required List<CurrencyUi> currencies})
      : this._(
          status: CurrencyListStateStatus.loaded,
          currencies: currencies,
        );

  final CurrencyListStateStatus status;
  final List<CurrencyUi> currencies;

  @override
  List<Object?> get props => [status];
}
