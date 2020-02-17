import 'dart:io';

import 'package:dkit/src/kernel/pipeline.dart';
import 'package:dkit/src/kernel/middleware.dart';

///请求处理类型
typedef RequestHandler = void Function(HttpRequest request);

///请求错误类型
typedef RequestErrorHandler = void Function(Error error, StackTrace trace);

///请求完成类型
typedef RequestCompleteHandler = void Function();

///HTTP服务封装
class Server
{
    ///监听地址
    dynamic address = '127.0.0.1';

    ///监听端口
    int port    = 8282;

    int backlog = 0;
    bool shared = false;

    SecurityContext securityContext;

    ///请求错误处理
    RequestErrorHandler errorHandler;

    ///请求完成处理
    RequestCompleteHandler completeHandler;

    HttpServer _srv;

    ///HTTP服务对象
    HttpServer get srv => _srv;

    ///监听请求
    void listen(RequestHandler handler, {List<Middleware<HttpServer>> middleware}) async
    {
        if(securityContext == null) {
            _srv = await HttpServer.bind(address, port, backlog: backlog, shared: shared);
        } else {
            _srv = await HttpServer.bindSecure(address, port, securityContext, backlog: backlog, shared: shared);
        }

        Pipeline<HttpServer>()..send(_srv)..pipes(middleware)..then((srv) {
            srv.listen(handler, onError: errorHandler, onDone: completeHandler, cancelOnError: true);
        });
    }
}