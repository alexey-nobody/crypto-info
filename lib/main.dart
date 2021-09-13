import 'package:crypto_info/common/env/build_types.dart';
import 'package:crypto_info/common/env/config.dart';
import 'package:crypto_info/common/env/debug_options.dart';
import 'package:crypto_info/common/env/environment.dart';
import 'package:crypto_info/common/logger/production_logger.dart';
import 'package:crypto_info/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.release,
    config: Config(
      logger: ProductionLogger(),
      debugOptions: DebugOptions(),
      poloniexApiUrl: 'https://www.poloniex.com/',
    ),
  );

  run();
}
