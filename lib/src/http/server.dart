import 'dart:io';

///Http处理器类型
typedef HttpHandler = void Function(HttpRequest request);

///默认Http处理器
void _defaultHandler(HttpRequest req) {
  req.response
    ..writeln('Welcome to chatiot!')
    ..close();
}

class Server {
  ///Http服务实例
  HttpServer _srv;

  ///Http请求处理器
  HttpHandler _handler = _defaultHandler;

  ///设置Http请求处理器
  void setHandler(HttpHandler handler) {
    _handler = handler;
  }

  ///Http服务监听
  void serve(
      {dynamic address = '127.0.0.1',
      int port = 8282,
      SecurityContext securityContext,
      int backlog = 0,
      bool shared = false}) async {
    if (securityContext == null) {
      _srv = await HttpServer.bind(address, port,
          backlog: backlog, shared: shared);
    } else {
      _srv = await HttpServer.bindSecure(address, port, securityContext,
          backlog: backlog, shared: shared);
    }

    _handler ??= _defaultHandler;

    //监听请求
    _srv.listen(_onData, onDone: _onDone, onError: _onError);
  }

  ///停止Http服务
  void stop({bool force = false}) {
    if (_srv != null) {
      _srv.close(force: force);
    }
  }

  ///判断Http服务是否正在运行
  bool running() => _srv != null;

  ///处理Http请求
  void _onData(HttpRequest request) {
    _handler(request);
  }

  void _onDone() {}

  ///处理Http错误
  void _onError(error, StackTrace stackTrace) {
    throw error;
  }
}
