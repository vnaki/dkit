import 'package:dkit/src/kernel/middleware.dart';

///管道
class Pipeline<T>
{
    T _thing;

    void send(T thing)
    {
        _thing = thing;
    }

    void pipes(List<Middleware<T>> pipes)
    {
        pipes?.forEach((pipe) => _thing = pipe(_thing));
    }

    void then(Function(T context) destination)
    {
        destination(_thing);
    }
}