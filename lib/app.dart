import 'package:flutter/material.dart';
import 'package:crypto_info/common/env/config.dart';
import 'package:crypto_info/common/env/debug_options.dart';
import 'package:crypto_info/common/env/environment.dart';
import 'package:crypto_info/common/routes_factory.dart';
import 'package:crypto_info/common/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
      title: 'Template Bloc',
      theme: lightTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: child!,
      ),
    );
  }
}
