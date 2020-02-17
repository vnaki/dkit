import 'dart:io';

///请求上下文
class Context
{
    final Map<String, dynamic> _values = {};
    final HttpRequest request;

    Context(this.request);

    void set(String name, dynamic value)
    {
        _values[name] = value;
    }

    void get(String name, {dynamic defaultValue})
    {
        return _values[name] ?? defaultValue;
    }

    void remove(String name)
    {
         _values?.remove(name);
    }

    void clear()
    {
        _values.clear();
    }

    @override
    String toString()
    {
        return super.toString();
    }
}