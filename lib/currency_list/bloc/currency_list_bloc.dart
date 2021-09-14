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
        super(const CurrencyListState.loading());

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

  @override
  Stream<CurrencyListState> mapEventToState(CurrencyListEvent event) async* {
    if (event is CurrencyListLoaded) {
      yield* _mapCurrencyListLoaded(event);
    } else if (event is CurrencyListSorted) {
      yield* _mapCurrencyListSorted(event);
    }
  }

  Stream<CurrencyListState> _mapCurrencyListLoaded(
    CurrencyListLoaded event,
  ) async* {
    try {
      yield const CurrencyListState.loading();

      _currencyResponse = await _currencyListRepository.getCurrency();

      yield CurrencyListState.loaded(
        currencies: _currencyListUi,
        sortingType: _currentSorting,
      );
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
    }
  }

  Stream<CurrencyListState> _mapCurrencyListSorted(
    CurrencyListSorted event,
  ) async* {
    _currentSorting = event.sortType;

    yield CurrencyListState.loaded(
      currencies: _currencyListUi,
      sortingType: _currentSorting,
    );
  }
}
