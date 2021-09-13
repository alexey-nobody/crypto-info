import 'package:equatable/equatable.dart';

class CurrencyListEvent extends Equatable {
  const CurrencyListEvent();

  @override
  List<Object?> get props => [];
}

class CurrencyListLoaded extends CurrencyListEvent {}
