import 'package:crypto_info/currency_list/model/currency_list_sorting_type.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:equatable/equatable.dart';

enum CurrencyListStateStatus { initial, loading, loaded }

class CurrencyListState extends Equatable {
  const CurrencyListState._({
    required this.status,
    this.currencies = const [],
    this.sortingType = CurrencyListSortingType.none,
  });

  const CurrencyListState.loading()
      : this._(status: CurrencyListStateStatus.loading);

  const CurrencyListState.loaded({
    required List<CurrencyUi> currencies,
    required CurrencyListSortingType sortingType,
  }) : this._(
          status: CurrencyListStateStatus.loaded,
          currencies: currencies,
          sortingType: sortingType,
        );

  final CurrencyListStateStatus status;
  final CurrencyListSortingType sortingType;
  final List<CurrencyUi> currencies;

  @override
  List<Object?> get props => [status, sortingType, currencies];
}
