import 'package:dkit/src/kernel.dart';
import 'package:dkit/src/kernel/logger.dart';

///日志记录器提供者
void loggerProvider(Kernel kernel)
{
    kernel.set(Symbol('logger'), (k) => Logger());
}