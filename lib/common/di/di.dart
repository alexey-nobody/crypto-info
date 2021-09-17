import 'package:crypto_info/common/env/build_types.dart';
import 'package:crypto_info/common/env/config.dart';
import 'package:crypto_info/common/env/environment.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerDependencies() async {
  final config = Environment<Config>.instance().config;

  getIt.registerSingleton<Dio>(Dio());

  final buildType = Environment<Config>.instance().buildType;
  if (buildType == BuildType.dev) {
    getIt<Dio>().interceptors.add(
          LogInterceptor(responseBody: true, requestBody: true),
        );
  }

  getIt.registerLazySingleton<CurrencyListRepository>(
    () => CurrencyListRepository(getIt<Dio>(), baseUrl: config.poloniexApiUrl),
  );
}
