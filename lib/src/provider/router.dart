import 'package:dkit/src/kernel.dart';
import 'package:dkit/src/kernel/router.dart';

///路由收集器提供者
void routerProvider(Kernel kernel)
{
    kernel.set(Symbol('router'), (k) => Collector.singleton());
}