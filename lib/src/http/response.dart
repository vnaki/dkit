import 'dart:convert';
import 'dart:io';

class Response {
  final HttpResponse _resp;

  Response(this._resp);

  ///添加请求头
  void addHeader(String value, {String name}) {
    name == null ? _resp.headers.value(value) : _resp.headers.add(name, value);
  }

  ///设置请求头
  void setHeader(String value, {String name}) {
    name == null ? _resp.headers.value(value) : _resp.headers.add(name, value);
  }

  ///添加响应Cookie
  void addCookie(String name, String value,
      {String path = '/',
      String domain = '',
      int expires = 0,
      bool httpOnly = true,
      bool secure = false,
      bool raw = false}) {
    var cookie = Cookie(name, raw ? value : Uri.encodeComponent(value));
    cookie.path = path;
    cookie.domain = domain;
    cookie.expires = DateTime.now().add(Duration(seconds: expires));
    cookie.maxAge = expires;
    cookie.secure = secure;
    cookie.httpOnly = httpOnly;

    _resp.cookies.add(cookie);
  }

  ///设置内容类型
  void setContentType(String contentType, {String charset = 'UTF-8'}) {
    setHeader(contentType + ';charset=' + charset, name: 'content-type');
  }

  ///设置Http跳转
  void redirect(Uri location, {int statusCode = HttpStatus.movedPermanently}) {
    _resp.redirect(location, status: statusCode);
  }

  ///设置响应内容
  void body(String content, int statusCode) {
    _resp.statusCode = statusCode;
    _resp.contentLength = content?.length;

    _resp.writeln(content ?? '');
  }

  ///设置普通内容
  void plain(String content, {int statusCode = HttpStatus.ok}) {
    setContentType('text/plain');
    body(content, statusCode);
  }

  ///设置HTML内容
  void html(String content, {int statusCode = HttpStatus.ok}) {
    setContentType('text/html');
    body(content, statusCode);
  }

  ///设置json内容
  void json(Object object, {int statusCode = HttpStatus.ok}) {
    setContentType('application/json');
    body(jsonEncode(object), statusCode);
  }

  ///刷新缓冲并关闭连接
  void flush() {
    _resp
      ..flush()
      ..close();
  }
}
