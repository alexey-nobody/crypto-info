import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_repository.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_state.dart';
import 'package:crypto_info/currency_list/model/currency_data_response.dart';
import 'package:crypto_info/currency_list/model/currency_list_sorting_type.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  CurrencyListBloc({
    required ErrorHandlerBloc errorHandlerBloc,
    required CurrencyListRepository currencyListRepository,
  })  : _currencyListRepository = currencyListRepository,
        _errorHandlerBloc = errorHandlerBloc,
        super(const CurrencyListState.loading()) {
    on<CurrencyListLoaded>(_onCurrencyListLoaded);
    on<CurrencyListSorted>(_onCurrencyListSorted);
  }

  final ErrorHandlerBloc _errorHandlerBloc;
  final CurrencyListRepository _currencyListRepository;

  Map<String, CurrencyDataResponse> _currencyResponse = {};

  CurrencyListSortingType _currentSorting = CurrencyListSortingType.none;

  List<CurrencyUi> get _currencyListUi {
    final listCurrencyUi = _currencyResponse.entries
        .map((entry) => CurrencyUi.fromResponse(
              currencyPair: entry.key,
              response: entry.value,
            ))
        .toList();

    if (_currentSorting == CurrencyListSortingType.priceDesc) {
      listCurrencyUi.sort((a, b) {
        final percentChangeA = double.parse(a.percentChange);
        final percentChangeB = double.parse(b.percentChange);
        return percentChangeA.compareTo(percentChangeB);
      });
    }

    if (_currentSorting == CurrencyListSortingType.priceAsc) {
      listCurrencyUi.sort((a, b) {
        final percentChangeA = double.parse(a.percentChange);
        final percentChangeB = double.parse(b.percentChange);
        return percentChangeA.compareTo(percentChangeB);
      });
      return listCurrencyUi.reversed.toList();
    }

    if (_currentSorting == CurrencyListSortingType.volumeDesc) {
      listCurrencyUi.sort((a, b) {
        final volumeA = double.parse(a.baseVolume);
        final volumeB = double.parse(b.baseVolume);
        return volumeA.compareTo(volumeB);
      });
    }

    if (_currentSorting == CurrencyListSortingType.volumeAsc) {
      listCurrencyUi.sort((a, b) {
        final volumeA = double.parse(a.baseVolume);
        final volumeB = double.parse(b.baseVolume);
        return volumeA.compareTo(volumeB);
      });
      return listCurrencyUi.reversed.toList();
    }

    return listCurrencyUi;
  }

  Future<void> _onCurrencyListLoaded(
    CurrencyListLoaded event,
    Emitter emit,
  ) async {
    try {
      _currencyResponse = await _currencyListRepository.getCurrency();

      emit(CurrencyListState.loaded(
        currencies: _currencyListUi,
        sortingType: _currentSorting,
      ));
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
    }
  }

  Future<void> _onCurrencyListSorted(
    CurrencyListSorted event,
    Emitter emit,
  ) async {
    _currentSorting = event.sortType;

    emit(CurrencyListState.loaded(
      currencies: _currencyListUi,
      sortingType: _currentSorting,
    ));
  }
}
