import 'package:crypto_info/common/env/debug_options.dart';
import 'package:crypto_info/common/logger/logger.dart';

class Config {
  const Config({
    required this.logger,
    required this.debugOptions,
    required this.poloniexApiUrl,
  });

  final Logger logger;
  final DebugOptions debugOptions;

  final String poloniexApiUrl;
}
