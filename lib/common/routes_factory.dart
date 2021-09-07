import 'package:crypto_info/currency_list/currency_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_info/common/routes.dart';

class RoutesFactory {
  static String get initialRoute => Routes.currencyList;

  Map<String, Widget Function(BuildContext)> get _routes => {
        Routes.currencyList: (context) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: CurrencyListPage(),
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
