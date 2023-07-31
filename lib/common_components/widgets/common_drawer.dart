import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jatya_patient_mobile/common_components/widgets/logout_alert.dart';
import 'package:jatya_patient_mobile/common_components/widgets/popup_widget.dart';
import 'package:jatya_patient_mobile/modules/Faq/screens/faq_screen.dart';
import 'package:jatya_patient_mobile/modules/Mediline/screens/my_mediline_screen.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/screens/MyJatya.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/screens/my_prescription_screen.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/screens/NewAppointment.dart';
import 'package:jatya_patient_mobile/modules/Notifications/screens/notification_screen.dart';
import 'package:jatya_patient_mobile/modules/Profile/screens/patient_profile_screen.dart';
import 'package:jatya_patient_mobile/modules/Reports/screens/main_report_screen.dart';
import 'package:jatya_patient_mobile/modules/search/screens/search_screen.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/constants/image_konstants.dart';
import 'package:jatya_patient_mobile/utils/helper/helper.dart';

import '../../modules/Notifications/bloc/notification_bloc.dart';
import '../../modules/SharedFiles/SharedFiles.dart';
import '../../utils/constants/terms_konstants.dart';
import 'about_jatya_dialog.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height / 932;
    final double tileHeight = devHeight * 50;

    String imageURL = sharedPrefs.getProfilePic == ""
        ? ImagesConstants.networkImageProfilePicPlacholder
        : sharedPrefs.getProfilePic;
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          //  title: Stack(
          //   children: <Widget>[
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: const <Widget>[
          //         Icon(CupertinoIcons.text_justify),
          //         SizedBox(width: 0),
          //         Text('My App'),
          //       ],
          //     ),
          //   ],
          // ),
          // The above code can be used to add icon before jatya title.
          title: const Text('Jatya'),
          centerTitle: false,
          leading: IconButton(
            icon: Image.asset(ImagesConstants.jatyalogoCircular),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "My Jatya",
                        image: ImagesConstants.myJatyaDrawer),
                    onTap: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyJatya()));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyJatya(),
                        ),
                        (route) =>
                            false, // Remove all existing routes from the stack
                      );
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Medi-line",
                        image: ImagesConstants.medilineDrawer),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyMedilineScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Prescriptions",
                        image: ImagesConstants.prescriptionDrawer),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyPrescriptionScreen(),
                          // List<GetAllClinicData> clinicListData = [];
                          //BlocProvider.of<GetAllClinicBloc>(context).add(GetAllClinicEvents());
                          // return BlocListener<GetAllClinicBloc, ClinicwisePrescriptionState>(
                          //     listener: (context, state) {
                          //      if (state is ClinicwiseSuccess) {
                          //        if (state.getAllClinicResponse.data != null) {
                          //          clinicListData = state.getAllClinicResponse.data!;
                          //         log("yes success");
                          //       } else if (state is ClinicwiseFailure) {
                          //         clinicListData = [];
                          //       }
                          //     }
                          //     },
                          //   child: MyPrescriptionScreen(clinicLIstData: clinicListData));

                          /*return BlocBuilder<GetAllClinicBloc,
                              ClinicwisePrescriptionState>(
                            builder: (context, state) {
                              if (state is ClinicwiseLoading) {
                                return const Scaffold(
                                  body: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (state is ClinicwiseSuccess) {
                                return MyPrescriptionScreen(
                                  clinicLIstData: state.getAllClinicResponse.data,
                                );
                              } else if (state is ClinicwiseFailure) {
                                return const MyPrescriptionScreen(
                                    clinicLIstData: []);
                              }
                              return const MyPrescriptionScreen(
                                  clinicLIstData: []);
                            },
                          );*/
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Reports", image: ImagesConstants.reportDrawer),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainReportsScreen(),
                        ),
                      );
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  thickness: 1,
                  endIndent: 0.3,
                  indent: 0.1,
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                      title: 'Book an Appointment',
                      image: ImagesConstants.appointmentDrawer,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NewAppointmentScreen()));
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Consult Doctor Online",
                        image: ImagesConstants.videoCallDrawer),
                    onTap: () {
                      WidgetHelper.showToast('Coming Soon!!');
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const NewOnlineConsultationScreen()));
                      // ...
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  thickness: 1,
                  endIndent: 0.3,
                  indent: 0.1,
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Search", image: ImagesConstants.searchDrawer),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Shared files",
                        image: ImagesConstants.shareDrawer),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SharedFiles()));
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Notifications",
                        image: ImagesConstants.notificationDrawer),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<NotificationBloc>(
                                      create: (context) => NotificationBloc(),
                                      child: const NotificationScreen())));
                      // NotificationScreen
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "FAQ", image: ImagesConstants.faqDrawer),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQScreen()));
                      // ...
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  thickness: 1,
                  endIndent: 0.3,
                  indent: 0.1,
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: Row(
                      children: [
                        Image.network(
                          imageURL,
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 5),
                        const Text('My Profile'),
                      ],
                    ),
                    /*const DrawerItem(
                        title: "My Profile",
                        image: ImagesConstants.profileimage,),*/
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const PatientProfileScreen();
                      }));
                      // ...
                    },
                  ),
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: ListTile(
                    title: const DrawerItem(
                        title: "Logout", image: ImagesConstants.logoutDrawer),
                    onTap: () {
                      Navigator.pop(context);
                      showPopup(
                          context: context, child: const LogoutAletDialog());
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  thickness: 1,
                  endIndent: 0.3,
                  indent: 0.1,
                ),
                //unline text "About the app" at the bottom of the drawer
                // const SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: devHeight * 100,
                ),
                Container(
                  height: tileHeight,
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const Text(
                      'About the app',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AboutJatyaDialog(
                            isAboutApp: true,
                            titleText: 'Jatya app',
                            text: TermsConstants.aboutApp,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String image;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 10),
        Text(title),
      ],
    );
  }
}
