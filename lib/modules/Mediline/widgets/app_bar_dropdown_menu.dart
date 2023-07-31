import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/Mediline/bloc/get_doctors_bloc.dart';
import 'package:jatya_patient_mobile/modules/Mediline/bloc/mediline_bloc.dart';
import 'package:jatya_patient_mobile/modules/Mediline/models/share_mediline_request.dart';
import 'package:jatya_patient_mobile/modules/Mediline/services/mediline_repository.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/helper/helper.dart';

import '../../../common_components/widgets/app_alert_dialog.dart';
import '../../../common_components/widgets/link_text.dart';
import '../../../common_components/widgets/popup_widget.dart';
import '../screens/share_mediline_screen.dart';

class AppBarDropDownMenu extends StatefulWidget {
  final bool isMandatory;
  const AppBarDropDownMenu({
    super.key,
    this.isMandatory = false,
  });

  @override
  State<AppBarDropDownMenu> createState() => _AppBarDropDownMenuState();
}

class _AppBarDropDownMenuState extends State<AppBarDropDownMenu> {
  final GlobalKey _key = LabeledGlobalKey("button_icon");
  bool isActive = false;
  late OverlayEntry _overlayEntry;
  late Size buttonSize;
  late Offset buttonPosition;

  bool isMenuOpen = false;
  late FixedExtentScrollController scrollController;

  findButton() {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  @override
  void initState() {
    scrollController = FixedExtentScrollController();
    super.initState();
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(builder: (context) {
      return Container(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            closeMenu();
            // showPopup(context: context, child: ShareMedilinePopup(appointmentDetail: appointmentDetail));
          },
          child: Stack(
            children: [
              Positioned(
                  top: buttonPosition.dy + buttonSize.height,
                  left: buttonPosition.dx - 170,
                  width: 180,
                  child: Container(
                      color: Colors.white,
                      child: Material(
                        color: Colors.white,
                        elevation: 10,
                        child: dropDown(),
                      )))
            ],
          ),
        ),
      );
    });
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onLongPress: () {
          HapticFeedback.lightImpact();
          setState(() {
            isActive = true;
          });
        },
        onLongPressUp: () {
          setState(() {
            isActive = false;
          });
        },
        onTap: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
        child: Container(
          key: _key,
          // padding: const EdgeInsets.all(4),
          child: const Icon(Icons.more_vert),
        ),
      ),
    );
  }

  Widget dropDown() {
    return Column(children: [
      ListTile(
        dense: true,
        onTap: () {
          closeMenu();
          showPopup(
              context: context,
              child: AppAlertDialog(
                  iconColor: Colors.orange.shade800,
                  icon: const Icon(
                    Icons.warning_rounded, color: Colors.white,
                    // size: 55,
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      const Text(
                          "You are trying to share your mediline with other clinics you visited. Your mediline is sensitive information & you own complete responsibility when you share it with others.\n\nBy clicking \"OK, Proceed\" button, you are abiding by the terms & condition of medical data handling standards."),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<MedilineBloc, MedilineState>(
                        builder: (context, state) {
                          if (state is MedilineErrorState) {
                            const Center(
                              child: Text("Something Went Wrong!"),
                            );
                          }
                          if (state is MedilineLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is MedilineSuccessState) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      //Navigator.pop(context);
                                      showPopup(
                                          context: context,
                                          child: BlocProvider<GetAllDoctorsBloc>(
                                              create: (context) => GetAllDoctorsBloc(),
                                              child: ShareMedilinePopup(
                                              shareFunction: (
                                                  {required String
                                                      doctorId}) async {
                                                bool res = false;

                                                await MedilineRepository()
                                                    .shareMediline(
                                                        shareMedilineRequest: [
                                                      ShareMedilineRequest(
                                                          patientId: sharedPrefs
                                                              .patientId!,
                                                          sharedById:
                                                              sharedPrefs.id!,
                                                          sharedToId: doctorId)
                                                    ]).then((value) {
                                                  res = true;
                                                }).catchError((e) {
                                                  WidgetHelper.showToast(
                                                      e.toString());
                                                });
                                                return res;
                                              },
                                              revokeFunction: (
                                                  {required String
                                                      doctorId}) async {
                                                bool res = true;
                                                await MedilineRepository().revokeShareMediline(
                                                    sharedToId: doctorId,
                                                  patientId: sharedPrefs
                                                      .patientId!,
                                                  sharedById:
                                                  sharedPrefs.id!
                                                ).then((value) {
                                                  res = false;
                                                }).catchError((e) {
                                                  WidgetHelper.showToast(
                                                      e.toString());
                                                });
                                                return res;
                                              },
                                              appointmentDetailList:
                                                  state.appointmentList ?? [])));
                                    },
                                    child: const Text("Ok Proceed")));
                          }
                          return const Center(
                            child: Text("Something Went Wrong!"),
                          );
                        },
                      ),
                      LinkText(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Cancel")
                    ],
                  )));
          // showPopup(
          //   context: context,
          //   child: const ShareMedilinePopup(),
          // );
        },
        title: Row(
          children: [
            Icon(
              Icons.share,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text("Share Mediline with"),
          ],
        ),
      )
    ]);
  }
}
