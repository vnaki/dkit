import 'dart:io';

import 'package:dkit/src/kernel/context.dart';
import 'package:dkit/src/kernel/container.dart';
import 'package:dkit/src/kernel/middleware.dart';
import 'package:dkit/src/kernel/pipeline.dart';
import 'package:dkit/src/kernel/router.dart';
import 'package:dkit/src/kernel/server.dart';
import 'package:dkit/src/middleware/req/access_log.dart';
import 'package:dkit/src/middleware/srv/timeout.dart';
import 'package:dkit/src/provider/logger.dart';
import 'package:dkit/src/provider/router.dart';

///服务提供者类型
typedef Provider = void Function(Kernel kernel);

///内核驱动
class Kernel extends Container
{
    ///静态实例
    static dynamic app;

    ///内核版本号
    String get version => '0.0.2';

    ///服务提供者
    List<Provider> providers = [loggerProvider, routerProvider];

    ///服务中间件
    List<Middleware<HttpServer>> serverMiddleware = [timeout];

    ///请求中间件
    List<Middleware<Context>> requestMiddleware   = [accessLog];

    ///HTTP服务对象
    final Server server = Server();

    ///初始化内核
    Kernel()
    {
        app = this;
        providers.forEach((provider) => provider(this));
    }

    ///创建单例实例
    factory Kernel.singleton()
    {
        return app ??= Kernel();
    }

    ///启动服务监听
    void run() async
    {
        server.listen(_handleRequest, middleware: serverMiddleware);
    }

    ///处理请求
    void _handleRequest(HttpRequest req)
    {
        Pipeline<Context>()..send(Context(req))..pipes(requestMiddleware)..then((context) {
            Dispatcher(context)..dispatch();
        });
    }

    @override
    dynamic noSuchMethod(Invocation invocation)
    {
        if (!invocation.isMethod && has(invocation.memberName))
        {
            return get(invocation.memberName, singleton: true);
        }

        return super.noSuchMethod(invocation);
    }
}