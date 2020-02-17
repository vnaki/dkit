import 'dart:io';

import 'package:dkit/dkit.dart';
import 'package:dkit/src/facade/router.dart';

class App extends Kernel
{
}

void main(List<String> arguments)
{
    var app = App();
    print(app == Kernel.app);

}
