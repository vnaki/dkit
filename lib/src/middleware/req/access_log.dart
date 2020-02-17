import 'package:dkit/src/kernel/context.dart';

///跨站请求伪造攻击中间件
Context accessLog(Context context)
{
    var req = context.request;

    print('method: '+req.method+' path: '+req.uri.path+' time: '+DateTime.now().millisecondsSinceEpoch.toString());
    return context;
}