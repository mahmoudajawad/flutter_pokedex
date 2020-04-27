import 'dart:io';
import 'dart:developer' as developer;

enum LogType {
  DEBUG,
  ERR,
}

void log(LogType type, dynamic message) {
  if (type == LogType.DEBUG) {
    developer.log(message.toString());
  } else if (type == LogType.ERR) {
    stderr.write(message);
  }
}
