import 'package:dkit/src/kernel/context.dart';

///响应超时中间件, 默认10秒
Context timeout(Context context)
{
    context.request.response.deadline = Duration(seconds: 10);
    return context;
}