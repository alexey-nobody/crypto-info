import 'package:crypto_info/common/logger/logger.dart';
import 'package:flutter/material.dart';

class DevLogger extends Logger {
  @override
  void e({required Object error, String? message, StackTrace? stackTrace}) {
    stackTrace ??= StackTrace.current;

    debugPrint('====================== Error log: =========================');
    if (message != null) debugPrint('Message: $message');
    debugPrint('> Error:');
    debugPrint(error.toString());
    debugPrint('> StackTrace:');
    debugPrint(stackTrace.toString());
    debugPrint('============================================================');
  }
}
