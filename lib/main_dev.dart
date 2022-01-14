import 'package:crypto_info/common/debug_bloc_observer.dart';
import 'package:crypto_info/common/env/build_type.dart';
import 'package:crypto_info/common/env/config.dart';
import 'package:crypto_info/common/env/debug_options.dart';
import 'package:crypto_info/common/env/environment.dart';
import 'package:crypto_info/common/logger/dev_logger.dart';
import 'package:crypto_info/common/runner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DebugBlocObserver();

  Environment.init(
    buildType: BuildType.dev,
    config: Config(
      logger: DevLogger(),
      debugOptions: DebugOptions(),
      poloniexApiUrl: 'https://www.poloniex.com/',
    ),
  );

  run();
}
