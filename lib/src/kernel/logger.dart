import 'dart:io';

///日志适配器接口
abstract class LoggerAdapter
{
    void write(String content);
}

///文件适配器
class FileAdapter extends LoggerAdapter
{
    ///文件最大尺寸,单位MB
    final int _maxSize;

    ///文件路径
    final String _filePath;

    ///初始化文件适配器
    FileAdapter(String filePath, {int maxSize = 1}): _filePath = filePath, _maxSize = maxSize;

    @override
    void write(String content)
    {
        var file = File(_filePath);

        file.readAsBytes().then((bytes) {
            print(bytes.length);
        }, onError: () {

        });

        file.writeAsStringSync(content, mode: FileMode.writeOnly);
    }
}

///标准输入输出适配器
class StdAdapter extends LoggerAdapter
{
    @override
    void write(String content)
    {
        stdout..write(content)..close();
    }
}

///日志记录器接口
abstract class ILogger
{
    void info(String message);

    void debug(String message);

    void warn(String message);

    void error(String message);

    void fatal(String message);
}

///日记默认等级
const Set<String> DefaultLogLevels =
{
    Logger.INFO,
    Logger.DEBUG,
    Logger.WARN,
    Logger.ERROR,
    Logger.FATAL
};

///日志记录器
class Logger extends ILogger
{
    ///普通日志
    static const INFO = 'INFO';

    ///调试日志
    static const DEBUG = 'DEBUG';

    ///警告日志
    static const WARN = 'WARN';

    ///错误日志
    static const ERROR = 'ERROR';

    ///致命错误
    static const FATAL = 'FATAL';

    ///日志适配器
    final LoggerAdapter _adapter;

    ///日志等级
    final Set<String> _levels;

    ///初始化日志记录器
    Logger({LoggerAdapter adapter, Set<String> levels}): _adapter = adapter ?? StdAdapter(), _levels = levels ?? DefaultLogLevels;

    ///获取当前日期字符串
    String _now()
    {
        var now = DateTime.now();

        return now.year.toString() +
            '-' +
            now.month.toString().padLeft(2, '0') +
            '-' +
            now.day.toString().padLeft(2, '0') +
            ' ' +
            now.hour.toString().padLeft(2, '0') +
            ':' +
            now.minute.toString().padLeft(2, '0') +
            ':' +
            now.second.toString().padLeft(2, '0');
    }

    ///记录日志,可自定义日志等级[level]
    void log(String message, String level)
    {
        if (_levels.contains(level)) {
            _adapter.write('$_now() $level ' + message);
        }
    }

    ///记录`INFO`级别日志
    @override
    void info(String message) => log(message, Logger.INFO);

    ///记录`DEBUG`级别日志
    @override
    void debug(String message) => log(message, Logger.DEBUG);

    ///记录`WARN`级别日志
    @override
    void warn(String message) => log(message, Logger.WARN);

    ///记录`ERROR`级别日志
    @override
    void error(String message) => log(message, Logger.ERROR);

    ///记录`FATAL`级别日志
    @override
    void fatal(String message) => log(message, Logger.FATAL);
}
