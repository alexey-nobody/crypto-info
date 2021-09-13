import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_repository.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_state.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  CurrencyListBloc({
    required ErrorHandlerBloc errorHandlerBloc,
    required CurrencyListRepository currencyListRepository,
  })  : _currencyListRepository = currencyListRepository,
        _errorHandlerBloc = errorHandlerBloc,
        super(const CurrencyListState.loading());

  final ErrorHandlerBloc _errorHandlerBloc;
  final CurrencyListRepository _currencyListRepository;

  @override
  Stream<CurrencyListState> mapEventToState(CurrencyListEvent event) async* {
    if (event is CurrencyListLoaded) {
      yield* _mapCurrencyListLoaded(event);
    }
  }

  Stream<CurrencyListState> _mapCurrencyListLoaded(
    CurrencyListLoaded event,
  ) async* {
    try {
      yield const CurrencyListState.loading();
      final currencyListResponse = await _currencyListRepository.getCurrency();
      final currencyListUi = currencyListResponse.entries
          .map((entry) => CurrencyUi.fromResponse(
                currencyPair: entry.key,
                response: entry.value,
              ))
          .toList();
      yield CurrencyListState.loaded(currencies: currencyListUi);
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
    }
  }
}
