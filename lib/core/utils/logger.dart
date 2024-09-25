import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  static LogMode _logMode = LogMode.debug;
  static LogLevel _logLevel = LogLevel.trace;

  static void init(LogMode mode, LogLevel level) {
    Logger._logMode = mode;
    Logger._logLevel = level;
  }

  static void log(LogLevel level, dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug && level.index <= _logLevel.index) {
      String stackTraceStr = "";
      if(stackTrace != null) {
        Trace trace = Trace.from(stackTrace);
        stackTraceStr = trace.frames[0].toString();
      }

      if(kDebugMode) {
        print("${level.name}: $data <- $stackTraceStr");
      }
    }
  }

  static void fatal(dynamic data, {StackTrace? stackTrace}) {
    log(LogLevel.fatal, data, stackTrace: stackTrace);
  }

  static void error(dynamic data, {StackTrace? stackTrace}) {
    log(LogLevel.error, data, stackTrace: stackTrace);
  }

  static void warn(dynamic data, {StackTrace? stackTrace}) {
    log(LogLevel.warn, data, stackTrace: stackTrace);
  }

  static void info(dynamic data, {StackTrace? stackTrace}) {
    log(LogLevel.info, data, stackTrace: stackTrace);
  }

  static void debug(dynamic data, {StackTrace? stackTrace}) {
    log(LogLevel.debug, data, stackTrace: stackTrace);
  }

  static void trace(dynamic data, {StackTrace? stackTrace}) {
    log(LogLevel.trace, data, stackTrace: stackTrace);
  }
}

enum LogMode { debug, live }

enum LogLevel {
  fatal,
  error,
  warn,
  info,
  debug,
  trace
}
