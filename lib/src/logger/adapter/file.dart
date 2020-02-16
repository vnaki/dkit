import 'dart:io';

import 'package:dkit/src/logger/logger.dart';

///文件适配器
class FileAdapter extends LoggerAdapter {
  ///文件最大尺寸,单位MB
  final int _maxSize;

  ///文件路径
  final String _filePath;

  ///初始化文件适配器
  FileAdapter(String filePath, {int maxSize = 1})
      : _filePath = filePath,
        _maxSize = maxSize;

  @override
  void write(String content) {
    var file = File(_filePath);

    file.readAsBytes().then((bytes) {
      print(bytes.length);
    }, onError: () {});

    file.writeAsStringSync(content, mode: FileMode.writeOnly);
  }
}
