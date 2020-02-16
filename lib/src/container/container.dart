///注册名已存在
class RegisteredNameError extends Error {
    final String _message;

    RegisteredNameError(this._message);

    @override
    String toString() => '错误: $_message';
}

///注册名不存在
class UnregisteredNameError extends Error {
    final String _message;

    UnregisteredNameError(this._message);

    @override
    String toString() => '错误: $_message';
}

///控制反转容器接口
abstract class IContainer {
    void set(Symbol name, Factory factory);

    dynamic get(Symbol name, {bool singleton = true});

    void unset(Symbol name);

    bool has(Symbol name);

    bool hasCache(Symbol name);
}

///工厂函数接口
typedef Factory = dynamic Function(IContainer container);

///控制反转容器
class Container
    implements IContainer {
    final Map<Symbol, Factory> _factories = {};
    final Map<Symbol, dynamic> _cached = {};

    ///注册工厂函数
    @override
    void set(Symbol name, Factory factory) {
        if (has(name)) {
            throw RegisteredNameError("名称'$name'已被注册");
        }

        _factories[name] = factory;
    }

    ///调用工厂函数
    @override
    dynamic get(Symbol name, {bool singleton = true}) {
        if (!has(name)) {
            throw UnregisteredNameError("名称'$name'未注册");
        }

        if (!singleton || !hasCache(name)) {
            return _cached[name] = _factories[name](this);
        }

        return _cached[name];
    }

    ///删除工厂函数
    @override
    void unset(Symbol name) {
        _factories?.remove(name);
        _cached?.remove(name);
    }

    ///判断工厂函数是否存在
    @override
    bool has(Symbol name) {
        return _factories.containsKey(name);
    }

    ///判断指定[name]的缓存是否存在
    @override
    bool hasCache(Symbol name) {
        return _cached.containsKey(name);
    }
}