import 'dart:async';

import 'package:crypto_info/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  Paint.enableDithering = true;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
    () async => runApp(const App()),
    (object, stackTrace) {},
  );
}
