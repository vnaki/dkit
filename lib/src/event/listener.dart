///事件载体
class Event {
  ///事件位置
  final int index;

  ///事件名称
  final String event;

  ///附加数据
  final dynamic data;

  const Event(this.index, this.event, this.data);
}

///事件处理器类型
typedef EventHandler = void Function(Event);

///事件监听器
class Listener {
  final Map<String, List<EventHandler>> _events = {};

  ///添加一个事件监听器
  void addEvent(String event, EventHandler handler) {
    (_events[event] ??= []).add(handler);
  }

  ///移除事件
  void removeEvent(String event) {
    _events.remove(event);
  }

  ///通知事件
  void notice(String event, {dynamic data}) {
    _events[event]?.forEach((handler) => handler(Event(1, event, data)));
  }

  ///判断事件是否存在
  bool hasEvent(String event) {
    return _events.containsKey(event);
  }
}
