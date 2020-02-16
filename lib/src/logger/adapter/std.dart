import 'dart:io';

import 'package:dkit/src/logger/logger.dart';

///标准输入输出适配器
class StdAdapter extends LoggerAdapter {
  @override
  void write(String content) {
    stdout
      ..write(content)
      ..close();
  }
}
