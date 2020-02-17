
import 'package:dkit/src/kernel/context.dart';
import 'package:dkit/src/kernel/middleware.dart';

///HTTP方法
enum Method { GET, POST, PUT, PATCH, OPTIONS, DELETE }

///路由动作
typedef Action = void Function(Context context);

///路由信息
class Route
{
    ///路由路径
    final String path;

    ///路由动作
    final Action action;

    ///路由中间件
    final List<Middleware<Context>> middleware = [];

    ///路由匹配模式
    final Map<String, String> patterns = {};

    ///初始化路由
    Route(this.path, this.action);

    ///添加路由中间件
    void addMiddleware(Action action)
    {
        middleware.add(action);
    }

    ///添加路由参数匹配模式
    void addPattern(String name, String value)
    {
        patterns[name] = value;
    }
}

///路由收集器
class Collector
{
    ///已注册的路由
    final Map<Method, Route> _routes = {};

    ///全局路由参数匹配模式
    final Map<String, String> _patterns = {};

    ///注册[GET]方法路由
    Route get(String path, Action action) => route(Method.GET, path, action);

    ///注册[POST]方法路由
    Route post(String path, Action action) => route(Method.POST, path, action);

    ///注册[PUT]方法路由
    Route put(String path, Action action) => route(Method.PUT, path, action);

    ///注册[PATCH]方法路由
    Route patch(String path, Action action) => route(Method.PATCH, path, action);

    ///注册[DELETE]方法路由
    Route delete(String path, Action action) => route(Method.DELETE, path, action);

    ///注册[OPTIONS]方法路由
    Route options(String path, Action action) => route(Method.OPTIONS, path, action);

    ///注册指定[method]的路由
    Route route(Method method, String path, Action action) => _routes[method] = Route(path, action);

    ///添加参数匹配模式
    void pattern(String name, String value)
    {
        _patterns[name] = value;
    }

    ///获取注册的路由
    Map<Method, Route> get routes => _routes;

    ///获取路由匹配模式
    Map<String, String> get patterns => _patterns;
}

///路由调度器
class Dispatcher
{
    ///路由收集器
    final Context _context;

    ///初始化路由调度器
    Dispatcher(this._context);


    ///路由调度
    void dispatch()
    {

    }
}
