import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto_info/app.dart';

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
