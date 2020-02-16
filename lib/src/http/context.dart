import 'dart:io';

import 'package:dkit/src/http/request.dart';
import 'package:dkit/src/http/response.dart';


class ContextCache {
  final Map<String, String> _caches = {};

  void set(String name, dynamic value) {
    if (name != null) {
      _caches[name] = value;
    }
  }

  dynamic get(String name, {dynamic defaultValue}) {
    if (_caches.containsKey(name)) {
      return _caches[name];
    }
    return defaultValue;
  }

  void delete(String name) {
    if (_caches.containsKey(name)) {
      _caches.remove(name);
    }
  }

  void clear() {
    _caches.clear();
  }
}

///Http请求上下文
class Context {
  final Request _request;
  final Response _response;
  final ContextCache _contextCache;

  Context(HttpRequest req)
      : _response = Response(req.response),
        _request = Request(req),
        _contextCache = ContextCache();

  ///获取请求实例
  Request get request {
    return _request;
  }

  ///获取响应实例
  Response get response {
    return _response;
  }

  ///获取ContextCache实例
  ContextCache get cache {
    return _contextCache;
  }

  void next() {}
}
