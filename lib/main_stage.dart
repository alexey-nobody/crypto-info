import 'package:crypto_info/common/env/build_types.dart';
import 'package:crypto_info/common/env/config.dart';
import 'package:crypto_info/common/env/debug_options.dart';
import 'package:crypto_info/common/env/environment.dart';
import 'package:crypto_info/common/logger/dev_logger.dart';
import 'package:crypto_info/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.stage,
    config: Config(
      logger: DevLogger(),
      title: 'ENV Flutter application template with Bloc state manager',
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
