import 'package:dkit/src/helper/date_format.dart';
import 'package:dkit/src/kernel/context.dart';
import 'package:dkit/src/kernel/logger.dart';

///跨站请求伪造攻击中间件
Context accessLog(Context context)
{
    var message = 'method: ' + context.request.method + ', path: ' + context.request.uri.path + ', time: ' + DateTime.now().format();
    Logger.logger.info(message);
    return context;
}