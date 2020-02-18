import 'dart:io';

import 'package:dkit/dkit.dart';
import 'package:dkit/src/kernel/context.dart';
import 'package:dkit/src/kernel/middleware.dart';

///路由动作
typedef Action = void Function(Context context);

///路由信息
class Route
{
    ///路由动作
    final Action action;

    ///路由中间件
    final List<Middleware<Context>> middleware = [];

    ///初始化路由
    Route(this.action);

    ///添加路由中间件
    void addMiddleware(Action action)
    {
        middleware.add(action);
    }
}

///默认404路由
void _action404(Context context)
{
    context.html('[DKIT] 404 - Page not found!', statusCode: HttpStatus.notFound);
}

///路径修饰
String _trimPath(String path)
{
    if(path == '/' || path == '') {
        return '/';
    }

    if(!path.startsWith('/')) {
        path = '/' + path;
    }

    if(path.endsWith('/')) {
        path = path.replaceFirst('/' , '', path.length - 1);
    }

    return path.toLowerCase();
}

String _trimRight(String path)
{
    if(path != '/' && path.endsWith('/')) {
        path = path.replaceFirst('/' , '', path.length - 1);
    }

    return path.toLowerCase();
}

///路由收集器
class Collector
{
    static const String GET     = 'GET';
    static const String POST    = 'POST';
    static const String PUT     = 'PUT';
    static const String PATCH   = 'PATCH';
    static const String DELETE  = 'DELETE';
    static const String OPTIONS = 'OPTIONS';

    ///路由收集器实例
    static Collector collector;

    ///已注册的路由
    final Map<String, Map<String, Route>> _routes = {};

    ///404路由
    Action notFound = _action404;

    ///初始化路由收集器
    Collector()
    {
        collector = this;
    }

    ///创建单例路由收集器
    factory Collector.singleton()
    {
        return collector ??= Collector();
    }

    ///注册[GET]方法路由
    ///
    /// [path]格式:/shop/user, 右边没有斜线
    Route get(String path, Action action) => route(GET, path, action);

    ///注册[POST]方法路由
    Route post(String path, Action action) => route(POST, path, action);

    ///注册[PUT]方法路由
    Route put(String path, Action action) => route(PUT, path, action);

    ///注册[PATCH]方法路由
    Route patch(String path, Action action) => route(PATCH, path, action);

    ///注册[DELETE]方法路由
    Route delete(String path, Action action) => route(DELETE, path, action);

    ///注册[OPTIONS]方法路由
    Route options(String path, Action action) => route(OPTIONS, path, action);

    ///注册指定[method]的路由
    Route route(String method, String path, Action action) => (_routes[method] ??= {})[_trimPath(path)] = Route(action);

    ///获取注册的路由
    Map<String, Map<String, Route>> get routes => _routes;
}

///路由调度器
class Dispatcher
{
    ///请求上下文
    final Context _context;

    ///路由收集器
    final Collector _collector;

    ///初始化路由调度器
    Dispatcher(this._context): _collector = Kernel.app.router;

    ///路由调度
    void dispatch()
    {
        var req    = _context.request;
        var routes = _collector.routes[req.method] ?? {};
        var route  = routes[_trimRight(req.uri.path)];

        if(route != null) {
            Pipeline<Context>()..send(_context)..pipes(route.middleware ?? [])..then((c){
                route.action(c);
            });
        } else {
            _collector.notFound(_context);
        }
    }
}
