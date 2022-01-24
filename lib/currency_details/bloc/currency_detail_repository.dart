import 'package:crypto_info/currency_details/models/chart_data_query.dart';
import 'package:crypto_info/currency_details/models/chart_data_response.dart';
import 'package:crypto_info/currency_details/models/trade_history_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'currency_detail_repository.g.dart';

@RestApi()
abstract class CurrencyDetailRepository {
  factory CurrencyDetailRepository(Dio dio, {String baseUrl}) =
      _CurrencyDetailRepository;

  @GET('/public?command=returnChartData')
  Future<List<ChartDataResponse>> getChartData({
    @Queries() required ChartDataQuery parameters,
  });

  @GET('/public?command=returnTradeHistory')
  Future<List<TradeHistoryResponse>> getTradeHistory({
    @Query('currencyPair') required String currencyPair,
  });
}
