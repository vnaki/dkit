import 'dart:io';

class Request {
  final HttpRequest _req;
  final Map<String, String> _cookies = {};
  final Map<String, String> _headers = {};

  Request(this._req) {
    _req.cookies.forEach(
        (cookie) => _cookies[cookie.name] = Uri.decodeComponent(cookie.value));
    _req.headers.forEach((k, v) => _headers[k] = v[0]);
  }

  ///请求地址信息
  Uri get uri => _req.uri;

  ///请求Http方法
  String get method => _req.method;

  ///客户端信息
  HttpConnectionInfo get info => _req.connectionInfo;

  ///请求头信息
  Map<String, String> get headers => _headers;

  ///Cookies
  Map<String, String> get cookies => _cookies;

  ///从请求头中获取指定[name]的值
  String header(String name, {String defaultValue = ''}) =>
      _headers[name] ?? defaultValue;

  ///从Cookies中获取指定[name]的值
  String cookie(String name, {String defaultValue = ''}) =>
      _cookies[name] ?? defaultValue;

  ///从查询参数中获取指定[name]的值
  String get(String name, {String defaultValue = ''}) =>
      uri.queryParameters[name] ?? defaultValue;

  void post(String name, {String defaultValue = ''}) {}
}
