import 'dart:io';

///请求超时中间件
HttpServer timeout(HttpServer srv)
{
    srv.idleTimeout = Duration(seconds: 2);
    srv.timeout(Duration(seconds: 2));

    return srv;
}