import 'dart:convert';
import 'dart:io';

///上下文数据
class ContextData
{
    ///上下文数据
    final Map<String, dynamic> _data  = {};

    ///设置上下文值
    void set(String name, dynamic value)
    {
        _data[name] = value;
    }

    ///获取指定[name]数据
    void get(String name, {dynamic defaultValue})
    {
        return _data[name] ?? defaultValue;
    }

    ///移除指定[name]数据
    void remove(String name)
    {
        _data?.remove(name);
    }

    ///清空数据
    void clear()
    {
        _data.clear();
    }
}

///请求上下文
class Context
{
    ///HTTP请求对象
    final HttpRequest request;

    ///上下文数据
    final ContextData data = ContextData();

    ///请求的Cookie
    final Map<String, String> cookies = {};

    ///初始化上下文
    Context(this.request)
    {
        request.cookies.forEach((cookie) => cookies[cookie.name] = cookie.value);
    }

    ///获取指定[name]Cookie
    String cookie(String name, {String defaultValue})
    {
        return cookies[name] ?? defaultValue;
    }

    ///获取指定[name]查询参数
    String param(String name, {String defaultValue})
    {
        return request.uri.queryParameters[name] ?? defaultValue;
    }

    ///获取指定[name]表单数据
    String form(String name, {String defaultValue})
    {
        return defaultValue;
    }

    ///设置响应头信息
    void setHeader(String name, String value)
    {
        request.response.headers.set(name, value);
    }

    ///添加响应头信息
    void addHeader(String name, String value)
    {
        request.response.headers.add(name, value);
    }

    ///重定向
    void redirect(Uri location, {int statusCode = HttpStatus.movedPermanently}) async
    {
        await request.response.redirect(location, status: statusCode);
    }

    ///响应输出
    void response(String content, {int statusCode = HttpStatus.ok, String contentType, String charset = 'utf-8'}) async
    {
        setHeader('content-type', contentType + ';charset='+charset);

        request.response.statusCode    = statusCode;
        request.response.contentLength = content.length;

        request.response.write(content);

        await request.response.flush();
        await request.response.close();
    }

    ///纯文本响应输出
    void plain(String content, {int statusCode = HttpStatus.ok, String charset = 'utf-8'})
    {
        response(content, statusCode: statusCode, contentType: 'text/plain', charset: charset);
    }

    ///HTML响应输出
    void html(String content, {int statusCode = HttpStatus.ok, String charset = 'utf-8'})
    {
        response(content, statusCode: statusCode, contentType: 'text/html', charset: charset);
    }

    ///JSON响应输出
    void json(Object object, {int statusCode = HttpStatus.ok, String charset = 'utf-8'})
    {
        response(jsonEncode(object), statusCode: statusCode, contentType: 'application/json', charset: charset);
    }
}