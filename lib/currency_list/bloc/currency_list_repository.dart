import 'package:crypto_info/currency_list/model/currency_data_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'currency_list_repository.g.dart';

@RestApi()
abstract class CurrencyListRepository {
  factory CurrencyListRepository(Dio dio, {String baseUrl}) =
      _CurrencyListRepository;

  @GET('/public?command=returnTicker')
  Future<Map<String, CurrencyDataResponse>> getCurrency();
}
