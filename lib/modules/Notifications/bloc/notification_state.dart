part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  int page;
  bool isRead;
  NotificationLoading({
    required this.isRead,
    required this.page,
  });
}

class NotificationSuccess extends NotificationState {
  int page;
  bool isRead;
  List<NotificationModelData> loadedData;
  bool isMarkAllAsRead;
  int unreadCount;
  NotificationSuccess({
    required this.isRead,
    required this.loadedData,
    required this.page,
    this.isMarkAllAsRead = false,
    required this.unreadCount,
  });
}

class NotificationDetailLoading extends NotificationState {}

class NotificationDetailSuccess extends NotificationState {
  DoctorDetailsNotification? loadedData;
  NotificationDetailSuccess({this.loadedData});
}

class NotificationSuccessAddDataToList extends NotificationState {
  final int page;
  final bool isRead;
  final List<NotificationModelData>? loadedData;
  final bool? noNotifFoundCheck;
  const NotificationSuccessAddDataToList({
    required this.isRead,
    this.loadedData,
    this.noNotifFoundCheck,
    required this.page,
  });
}

class NotificationFailureSttae extends NotificationState {
  final String error;
  const NotificationFailureSttae({
    required this.error,
  });
}
