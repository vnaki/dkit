import 'dart:io';

import 'package:dkit/dkit.dart';

class App extends Kernel
{

}

void main(List<String> arguments)
{
    dynamic app = App();

    app.setLoggerAdapter(StdAdapter());
    app.setLogLevel(defaultLogLevels);

    app.router.get('/welcome', (Context context) {
        context.html('Hello, world!!');
    });

    app.router.get('/json', (Context context) {
        context.json([{'a':1000}, {'b': 9880}]);
    });

    app.router.get('/query', (Context context) {
        var size = context.query('size', defaultValue: '2000');

        context.html(size);
    });

    app.router.get('/content', (Context context) async {


        var  client = HttpClient();

        await client.get('https://www.luogel.com', 443, '/').then((HttpClientRequest req) {

        }).then((HttpClientResponse resp) {

        });
    });

    app.run();
}
