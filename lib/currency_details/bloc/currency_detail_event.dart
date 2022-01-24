import 'package:equatable/equatable.dart';

class CurrencyDetailEvent extends Equatable {
  const CurrencyDetailEvent();

  @override
  List<Object?> get props => [];
}

class CurrencyDetailLoaded extends CurrencyDetailEvent {
  const CurrencyDetailLoaded();
}
