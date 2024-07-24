import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ConnectivityStatusEvent {
  final ConnectivityStatusType type;

  ConnectivityStatusEvent(this.type);
}

enum ConnectivityStatusType {
  connected,
  disconnected,
}

class CloseNetWorkErrorPopupEvent {}

class CloseTimedOutPopupEvent {}
