
import 'package:dkit/src/kernel/error.dart';

///控制反转容器接口
abstract class IContainer
{
    void set(Symbol name, Factory factory);

    dynamic get(Symbol name, {bool singleton = true});

    void unset(Symbol name);

    bool has(Symbol name);

    bool hasCache(Symbol name);
}

///工厂函数接口
typedef Factory = dynamic Function(IContainer container);

///控制反转容器
class Container implements IContainer
{
    final Map<Symbol, Factory> _factories = {};
    final Map<Symbol, dynamic> _cached = {};

    ///注册工厂函数
    @override
    void set(Symbol name, Factory factory)
    {
        if (has(name)) {
            throw RegisteredNameError("Name '$name' is already registered");
        }

        _factories[name] = factory;
    }

    ///调用工厂函数
    @override
    dynamic get(Symbol name, {bool singleton = true})
    {
        if (!has(name)) {
            throw UnregisteredNameError("Name '$name' not registered");
        }

        if (!singleton || !hasCache(name)) {
            return _cached[name] = _factories[name](this);
        }

        return _cached[name];
    }

    ///删除工厂函数
    @override
    void unset(Symbol name)
    {
        _factories?.remove(name);
        _cached?.remove(name);
    }

    ///判断工厂函数是否存在
    @override
    bool has(Symbol name)
    {
        return _factories.containsKey(name);
    }

    ///判断指定[name]的缓存是否存在
    @override
    bool hasCache(Symbol name)
    {
        return _cached.containsKey(name);
    }
}

///注册名已存在
class RegisteredNameError extends BaseError
{
    RegisteredNameError(String message): super(message);
}

///注册名不存在
class UnregisteredNameError extends BaseError
{
    UnregisteredNameError(String message): super(message);
}
