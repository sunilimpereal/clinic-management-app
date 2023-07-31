import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/widgets/common_drawer.dart';
import 'package:clinic_app/common_components/widgets/error_alert_dialog.dart';
import 'package:clinic_app/modules/Notifications/bloc/notification_bloc.dart';
import 'package:clinic_app/modules/Notifications/models/notification_model.dart';
import 'package:clinic_app/modules/Notifications/widgets/custompopup.dart';
import 'package:clinic_app/modules/Notifications/widgets/notificattion_tile.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';
import '../services/notification_services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final ScrollController _scrollController;
  final NotificationBloc _dataBloc = NotificationBloc();
  int page = 1;
  int unreadCount = 0;
  bool isLoading = false;
  bool noNotifCheck = false;
  bool isRead = false;

  List<NotificationModelData> allNotifs = [];

  @override
  void initState() {
    super.initState();
    print("called init");
    _dataBloc.add(LoadDataNotificationsEvnet(page: page));
    _scrollController = ScrollController();

    _scrollController.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollListener);
    _dataBloc.close();
    super.dispose();
  }

  void _onScrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        noNotifCheck == false) {
      _dataBloc.add(LoadMoreNotificationsEvnet(page: ++page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      bloc: _dataBloc,
      listener: (context, state) {
        if (state is NotificationSuccess) {
          log("here in notification success");

          allNotifs = state.loadedData;
          unreadCount = state.unreadCount;
          // unreadCount = 0;

          // for (var element in state.loadedData) {
          //   if (element.read == false) {
          //     unreadCount++;
          //   }
          // }
          // if (state.isMarkAllAsRead) {
          //   unreadCount = 0;
          // }
        }
        if (state is NotificationSuccessAddDataToList) {
          // if (state.loadedData != null) {
          //   for (var element in state.loadedData!) {
          //     if (element.read == false) {
          //       unreadCount++;
          //     }
          //   }
          // }
          if (state.noNotifFoundCheck == true) {
            noNotifCheck = true;
          }
          if (allNotifs.isEmpty) {
            allNotifs = state.loadedData ?? [];
          } else {
            allNotifs += state.loadedData ?? [];
          }
        }
      },
      child: BlocBuilder<NotificationBloc, NotificationState>(
          bloc: _dataBloc,
          builder: (context, state) {
            log('here in bloc builder');
            if (state is NotificationSuccess ||
                state is NotificationSuccessAddDataToList ||
                (state is NotificationLoading && allNotifs.isNotEmpty)) {
              return body(
                context,
                state,
                allNotifs,
              );
            } else if (state is NotificationFailureSttae) {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("Notifications"),
                    ],
                  ),
                ),
                drawer: const CommonDrawer(),
                body: Center(
                  child: Text(state.error),
                ),
              );
            } else if (state is NotificationLoading) {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("Notifications"),
                    ],
                  ),
                ),
                drawer: const CommonDrawer(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("Notifications"),
                    ],
                  ),
                ),
                drawer: const CommonDrawer(),
                body: const Center(
                  child: Text('Something went wrong!'),
                ),
              );
            }
          }),
    );
  }

  Widget body(
    BuildContext context,
    var state,
    List<NotificationModelData> loadedData,
  ) {
    print("SIUUUUUUUUUU: $state");
    print("SIUUUUUUUUUU: ${state is NotificationLoading}");
    return Scaffold(
        appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Notifications"),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(6),
                    color: Colors.white,
                  ),
                  child: Text(
                    '$unreadCount',
                    style: const TextStyle(
                      color: ColorKonstants.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            actions: [
              state.isRead
                  ? TextButton(
                      onPressed: () {
                        _dataBloc.add(MarkAsReadEvent(
                            isRead: false, loadedData: loadedData, page: page));
                      },
                      child: const Text(
                        "Mark all as read",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        _dataBloc.add(UndoNotificationEvent(
                            isRead: true, loadedData: loadedData, page: page));
                      },
                      child: const Text(
                        "Undo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ]),
        drawer: const CommonDrawer(),
        body: NotificationListener<ScrollNotification>(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: loadedData.length,
                itemBuilder: (context, index) {
                  NotificationModelData data = loadedData[index];

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => FutureBuilder(
                              future: loadedData[index].actionType == "Doctor"
                                  ? NotificationReporsitory
                                      .getNotificationDoctorDetails(
                                          loadedData[index].id!)
                                  : null,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                if (snapshot.hasError) {
                                  return const ErrorAlertDialog(
                                      error: "Coming Soon");
                                }
                                if (snapshot.data == null) {
                                  return CustomPopupContent(
                                    notificationData: data,
                                    page: page,
                                    unreadCount: unreadCount,
                                    dataBloc: _dataBloc,
                                  );
                                }
                                return CustomPopupContent(
                                  notificationData: data,
                                  doctorDetails: snapshot.data,
                                  page: page,
                                  unreadCount: unreadCount,
                                  dataBloc: _dataBloc,
                                  // doctorName: snapshot.data.doctorName ?? ,
                                  // doctorImageUrl:
                                  //     snapshot.data!.doctorPictureUrl,
                                  // doctorSpeciality:
                                  //     snapshot.data!.doctorSpeciality,
                                );
                              },
                            ),
                          );
                        },
                        child: NotificationTile(
                          isBold: data.read ?? false ? false : true,
                          title: data.title ?? "Text data",
                          subTitle: data.description ?? "4 days ago",
                          iconData: Icons.calendar_today_rounded,
                        ),
                      ),
                      state is NotificationLoading &&
                              index + 1 == loadedData.length
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: ColorKonstants.primaryColor),
                            )
                          : Container(),
                    ],
                  );
                }),
          ),
        ));
  }
}
