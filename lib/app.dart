import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:crypto_info/common/bloc/error_handler_bloc/error_handler_state.dart';
import 'package:crypto_info/common/env/config.dart';
import 'package:crypto_info/common/env/debug_options.dart';
import 'package:crypto_info/common/env/environment.dart';
import 'package:crypto_info/common/error_listener.dart';
import 'package:crypto_info/common/routes_factory.dart';
import 'package:crypto_info/common/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  ErrorListener get _errorListener => ErrorListener();

  DebugOptions get _debug => Environment<Config>.instance().config.debugOptions;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: _debug.showPerformanceOverlay,
      debugShowMaterialGrid: _debug.debugShowMaterialGrid,
      checkerboardRasterCacheImages: _debug.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _debug.checkerboardOffscreenLayers,
      showSemanticsDebugger: _debug.showSemanticsDebugger,
      debugShowCheckedModeBanner: _debug.debugShowCheckedModeBanner,
      initialRoute: RoutesFactory.initialRoute,
      onGenerateRoute: RoutesFactory().getGeneratedRoutes,
      title: 'Crypto',
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: BlocProvider(
          create: (_) => ErrorHandlerBloc(
            Environment<Config>.instance().config.logger,
          ),
          child: BlocListener<ErrorHandlerBloc, ErrorHandlerState>(
            listener: _errorListener.listener,
            child: child!,
          ),
        ),
      ),
    );
  }
}
