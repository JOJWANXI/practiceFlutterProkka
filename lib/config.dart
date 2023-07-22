import 'dart:io';

class PathConfig {
  // const -- Constants: a compile-time value that doesn't change at runtime
  // it cannot hold a value that will be computed at runtime
  static const String path = '/home/jianing/anaconda3/envs/prokka/bin/prokka';

  // static getter -- it can include runtime-computed values.
  static String get environmentPath =>
      '/home/jianing/anaconda3/envs/prokka/bin:${Platform.environment['PATH']}';
  // Platform.environment: access environment variables in Dart
  // 'PATH' environment variable: used in os
  // specify a list of directories where executable programs are located
}
