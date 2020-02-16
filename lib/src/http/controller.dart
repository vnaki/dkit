
import 'package:dkit/src/http/context.dart';

///控制器对象
abstract class Controller {
  final Context _context;

  ///初始化控制器
  Controller(this._context);

  ///获取请求上下文
  Context get context => _context;
}
