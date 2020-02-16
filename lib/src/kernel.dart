
import 'package:dkit/src/container/provider.dart';
import 'package:dkit/src/container/container.dart';
import 'package:dkit/src/http/router.dart';

abstract class Kernel extends Container {
  ///内核版本号
  String get version => '0.0.1';

  ///服务提供者
  List<Provider> providers = [];

  ///全局路由动作
  List<Action> actions = [];

  void run() {
    providers.forEach((provider) => provider.handle(this));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (!invocation.isMethod && has(invocation.memberName)) {
      return get(invocation.memberName, singleton: true);
    }

    return super.noSuchMethod(invocation);
  }
}
