import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/common/di/di.dart';
import 'package:crypto_info/common/routes.dart';
import 'package:crypto_info/currency_details/currency_detail_page.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_bloc.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_event.dart';
import 'package:crypto_info/currency_list/bloc/currency_list_repository.dart';
import 'package:crypto_info/currency_list/currency_list_page.dart';
import 'package:crypto_info/currency_list/model/currency_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesFactory {
  static String get initialRoute => Routes.currencyList;

  Map<String, Widget Function(BuildContext)> get _routes => {
        Routes.currencyList: (context) => BlocProvider(
              create: (_) => CurrencyListBloc(
                errorHandlerBloc: context.read<ErrorHandlerBloc>(),
                currencyListRepository: getIt<CurrencyListRepository>(),
              )..add(const CurrencyListLoaded()),
              child: const AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: CurrencyListPage(),
              ),
            ),
        Routes.currencyDetail: (context) {
          final currency =
              ModalRoute.of(context)!.settings.arguments as CurrencyUi;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: CurrencyDetailPage(currency: currency),
          );
        },
      };

  Route<dynamic> getGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (context) => _routes[settings.name]!(context),
        );
    }
  }
}
