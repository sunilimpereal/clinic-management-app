import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic_app/modules/Notifications/models/doctorDetailNotification.dart';
import 'package:clinic_app/modules/Notifications/models/notification_model.dart';
import 'package:clinic_app/modules/Notifications/models/undoResponse.dart';
import 'package:clinic_app/modules/Notifications/services/notification_services.dart';
import 'package:clinic_app/utils/SharePref.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final List<NotificationModelData> _dataList = mockData;
  final int limit = 12;

  NotificationBloc() : super(const NotificationInitial()) {
    on<LoadDataNotificationsEvnet>(_loadNotifications);

    on<LoadMoreNotificationsEvnet>(_loadMoreNotifications);

    on<MarkAsReadEvent>(_markAsReadEvent);
    on<UndoNotificationEvent>(_undoAsReadEvent);
    on<NotificatinDetailEvent>(_notificationDetail);
    on<MarkNotificationAsReadEvent>(_markNotificationAsReadEvent);
  }

  FutureOr<void> _notificationDetail(
      NotificatinDetailEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationDetailLoading());
    DoctorDetailsNotification? doctorDetailNotification;
    try {
      if (sharedPrefs.authToken != null) {
        doctorDetailNotification =
            await NotificationReporsitory.getNotificationDoctorDetails(
                event.id);
      }
    } catch (e) {
      log(e.toString());
    }
    if (doctorDetailNotification != null) {
      emit(NotificationDetailSuccess(loadedData: doctorDetailNotification));
    }
  }

  FutureOr<void> _loadNotifications(
      LoadDataNotificationsEvnet event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading(
      page: event.page,
      isRead: true,
    ));
    // print(sharedPrefs.authToken.toString());
    // print(sharedPrefs.id);
    List<NotificationModelData> loadedData;
    NotificationResponse? notificationResponse;
    int? unreadCount = 0;
    try {
      if (sharedPrefs.id != null || sharedPrefs.authToken != null) {
        notificationResponse =
            await NotificationReporsitory.fetchAllNotifications(event.page,
                sharedPrefs.id ?? " ", sharedPrefs.authToken ?? " ");
        unreadCount = await NotificationReporsitory.unreadNotificationCount(
            sharedPrefs.id ?? " ", sharedPrefs.authToken ?? " ");
      }
    } catch (e) {
      log(e.toString());
    }

    if (notificationResponse != null) {
      if (notificationResponse.error == "No notifications for user found") {
        emit(NotificationFailureSttae(
            error: notificationResponse.error.toString()));
      } else {
        loadedData = notificationResponse.data!;
        loadedData.sort(((a, b) => a.id!.compareTo(b.id!)));
        print(loadedData);
        emit(NotificationSuccess(
          isRead: true,
          loadedData: loadedData,
          page: event.page,
          unreadCount: unreadCount ?? 0,
        ));
      }
    } else {
      log("in Notificationfailure");
      final startIndex = event.page * limit;
      loadedData = _dataList.take(startIndex).toList();

      emit(NotificationFailureSttae(
          error: notificationResponse?.error.toString() ??  ""));
    }
  }

  FutureOr<void> _loadMoreNotifications(
      LoadMoreNotificationsEvnet event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading(
      page: event.page,
      isRead: true,
    ));
    NotificationResponse? notificationResponse;
    List<NotificationModelData> loadedData;
    //event.page++;
    // if (kDebugMode) {
    //   print("page is${event.page}");
    // }

    notificationResponse = await NotificationReporsitory.fetchAllNotifications(
        event.page, sharedPrefs.id!, sharedPrefs.authToken!);

    if (notificationResponse != null) {
      if (notificationResponse.error == "No notifications for user found") {
        emit(NotificationSuccessAddDataToList(
            isRead: true, page: event.page, noNotifFoundCheck: true));
      } else {
        if (notificationResponse.data != null) {
          if (notificationResponse.data!.length < 12) {
            loadedData = notificationResponse.data!;
            emit(NotificationSuccessAddDataToList(
              isRead: true,
              loadedData: loadedData,
              page: event.page,
              noNotifFoundCheck: true,
            ));
          } else {
            loadedData = notificationResponse.data!;
            emit(NotificationSuccessAddDataToList(
              isRead: true,
              loadedData: loadedData,
              page: event.page,
              noNotifFoundCheck: false,
            ));
          }
        }
      }
    } else {
      emit(NotificationFailureSttae(
          error: notificationResponse!.error.toString()));
    }
  }

  FutureOr<void> _markNotificationAsReadEvent(MarkNotificationAsReadEvent event,
      Emitter<NotificationState> emit) async {
    emit(
      NotificationLoading(
        isRead: true,
        page: event.page,
      ),
    );
    int unreadCount = event.unreadCount;
    try {
      if (event.notificationData.read!) {
        await NotificationReporsitory().markAsUnRead(
          event.notificationData.id!,
        );
        unreadCount++;
      } else {
        await NotificationReporsitory().markAsRead(
          event.notificationData.id!,
        );
        unreadCount--;
      }
    } catch (e) {
      log(e.toString());
    }
    NotificationResponse? notificationResponse;

    notificationResponse = await NotificationReporsitory.fetchAllNotifications(
        event.page, sharedPrefs.id!, sharedPrefs.authToken!);

    if (notificationResponse != null && notificationResponse.data != null) {
      notificationResponse.data!.sort(((a, b) => a.id!.compareTo(b.id!)));
      print('here in notification blocc');

      emit(
        NotificationSuccess(
          isRead: true,
          loadedData: notificationResponse.data ?? [],
          page: event.page,
          unreadCount: unreadCount,
        ),
      );
    }
  }

  FutureOr<void> _markAsReadEvent(
      MarkAsReadEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading(
      page: event.page,
      isRead: false,
    ));
    print("in bloc ${event.isRead}");
    UndoResponseData? undoResponseData;
    int? unreadCount;
    try {
      log("calling in read in bloc");
      if (sharedPrefs.id != null || sharedPrefs.authToken != null) {
        undoResponseData = await NotificationReporsitory.readAllNotifications(
            sharedPrefs.id ?? " ", sharedPrefs.authToken ?? " ");
        unreadCount = await NotificationReporsitory.unreadNotificationCount(
            sharedPrefs.id ?? " ", sharedPrefs.authToken ?? " ");
      }
    } catch (e) {
      log(e.toString());
    }
    NotificationResponse? notificationResponse;

    notificationResponse = await NotificationReporsitory.fetchAllNotifications(
        event.page, sharedPrefs.id!, sharedPrefs.authToken!);

    if (notificationResponse != null && notificationResponse.data != null) {
      notificationResponse.data!.sort(((a, b) => a.id!.compareTo(b.id!)));

      emit(NotificationSuccess(
          isRead: false,
          loadedData: notificationResponse.data ?? event.loadedData,
          page: event.page,
          isMarkAllAsRead: true,
          unreadCount: unreadCount ?? 0));
    }
  }

  FutureOr<void> _undoAsReadEvent(
      UndoNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading(
      page: event.page,
      isRead: true,
    ));
    UndoResponseData? undoResponseData;
    int? unreadCount;
    try {
      log("calling in undo in bloc");
      if (sharedPrefs.id != null || sharedPrefs.authToken != null) {
        undoResponseData = await NotificationReporsitory.undoAllNotifications(
            sharedPrefs.id ?? " ", sharedPrefs.authToken ?? " ");
        unreadCount = await NotificationReporsitory.unreadNotificationCount(
            sharedPrefs.id ?? " ", sharedPrefs.authToken ?? " ");
      }
    } catch (e) {
      log(e.toString());
    }
    NotificationResponse? notificationResponse;

    notificationResponse = await NotificationReporsitory.fetchAllNotifications(
        event.page, sharedPrefs.id!, sharedPrefs.authToken!);
    event.loadedData.sort(((a, b) => a.id!.compareTo(b.id!)));
    if (notificationResponse != null && notificationResponse.data != null) {
      notificationResponse.data!.sort(((a, b) => a.id!.compareTo(b.id!)));
      emit(
        NotificationSuccess(
          isRead: true,
          loadedData: notificationResponse.data ?? event.loadedData,
          page: event.page,
          unreadCount: unreadCount ?? 0,
        ),
      );
    }
  }
}
