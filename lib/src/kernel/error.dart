///基础错误
abstract class BaseError extends Error
{
    final String _message;

    BaseError(this._message);

    @override
    String toString() => 'error: $_message';
}