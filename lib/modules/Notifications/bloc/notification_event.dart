part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadDataNotificationsEvnet extends NotificationEvent {
  int page;

  LoadDataNotificationsEvnet({required this.page});
}

class LoadMoreNotificationsEvnet extends NotificationEvent {
  int page;
  LoadMoreNotificationsEvnet({required this.page});
}

class MarkAsReadEvent extends NotificationEvent {
  bool isRead;
  List<NotificationModelData> loadedData;
  int page;

  MarkAsReadEvent({
    required this.isRead,
    required this.loadedData,
    required this.page,
  });
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final NotificationModelData notificationData;
  final int page;
  final int unreadCount;

  const MarkNotificationAsReadEvent({
    required this.notificationData,
    required this.page,
    required this.unreadCount,
  });
}

class UndoNotificationEvent extends NotificationEvent {
  bool isRead;
  List<NotificationModelData> loadedData;
  int page;
  UndoNotificationEvent(
      {required this.isRead, required this.loadedData, required this.page});
}

class NotificatinDetailEvent extends NotificationEvent {
  String id;
  NotificatinDetailEvent({required this.id});
}
