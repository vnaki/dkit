import 'package:dkit/src/container/container.dart';

///服务提供者接口
abstract class Provider {
  void handle(IContainer container);
}
