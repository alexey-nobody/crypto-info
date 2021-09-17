import 'package:crypto_info/currency_list/model/currency_list_sorting_type.dart';
import 'package:equatable/equatable.dart';

class CurrencyListEvent extends Equatable {
  const CurrencyListEvent();

  @override
  List<Object?> get props => [];
}

class CurrencyListLoaded extends CurrencyListEvent {
  const CurrencyListLoaded();
}

class CurrencyListSorted extends CurrencyListEvent {
  const CurrencyListSorted(this.sortType);

  final CurrencyListSortingType sortType;

  @override
  List<Object?> get props => [sortType];
}
