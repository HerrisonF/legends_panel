import 'package:flutter/material.dart';
import 'package:legends_panel/app/core/error_base/failure.dart';
import 'package:legends_panel/app/core/logger/logger.dart';

class LoggerImpl extends Logger {

  static const _LENGTH_OF_WRAP_LOG = 1000;

  @override
  void logERROR(Failure failure) {
    logDEBUG(failure.logFullError());
  }

  /// Loga apenas em DEBUG
  @override
  void logDEBUG(String message) {
    debugPrint(message, wrapWidth: _LENGTH_OF_WRAP_LOG);
  }
}
