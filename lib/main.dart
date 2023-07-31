import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/modules/Auth/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:jatya_patient_mobile/modules/Auth/bloc/register_bloc/register_bloc.dart';
import 'package:jatya_patient_mobile/modules/Auth/services/auth_repository.dart';
import 'package:jatya_patient_mobile/modules/Faq/bloc/faq_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/bloc/upcoming_apppointment/upcoming_appointmen_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyJatya/screens/MyJatya.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/bloc/getClinicIWisePrescription/get_prescription_clinic_wise_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/bloc/get_all_clinic_bloc/bloc/get_all_clinic_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/bloc/get_prescription_bloc_bloc.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/bloc/myPrescriptionBloc/my_prescription_bloc.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/bloc/appointment_bloc.dart';
import 'package:jatya_patient_mobile/modules/NewAppointment/services/appointment_repository.dart';
import 'package:jatya_patient_mobile/modules/Notifications/bloc/notification_bloc.dart';
import 'package:jatya_patient_mobile/modules/Onboarding/screens/mainonboarding_screen.dart';
import 'package:jatya_patient_mobile/modules/Profile/bloc/patient_bloc/patient_bloc.dart';
import 'package:jatya_patient_mobile/modules/Profile/bloc/upload_profile_pic_bloc/upload_profile_pic_bloc.dart';
import 'package:jatya_patient_mobile/modules/Profile/bloc/vaccinations_bloc/vaccinations_bloc.dart';
import 'package:jatya_patient_mobile/modules/Reports/bloc/get_recent_reports/get_all_reports_bloc.dart';
import 'package:jatya_patient_mobile/modules/SharedFiles/bloc/sharedfiles_bloc.dart';
import 'package:jatya_patient_mobile/modules/search/bloc/search_bloc.dart';
import 'package:jatya_patient_mobile/utils/SharePref.dart';
import 'package:jatya_patient_mobile/utils/constants/theme_konstants.dart';

import 'firebase_options.dart';
import 'modules/Auth/bloc/login_bloc/login_bloc.dart';
import 'modules/Auth/screens/login_screen.dart';
import 'modules/Mediline/bloc/mediline_bloc.dart';
import 'modules/Mediline/bloc/search_bloc/mediline_search_bloc.dart';
import 'modules/Profile/bloc/previous_report_bloc/previousreport_bloc.dart';
import 'modules/Profile/bloc/update_patient_bloc/updatepatient_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic('Jatya-Push-Notification');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await sharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      "Handling a background message: ${message.data} ${message.notification?.title}  ${message.notification?.body}");
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  void initFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(context.read<AuthRepository>())),
          BlocProvider<UploadProfilePicBloc>(
              create: (context) => UploadProfilePicBloc()),
          BlocProvider<ForgotPasswordBloc>(
              create: (context) =>
                  ForgotPasswordBloc(authRepository: AuthRepository())),
          BlocProvider<RegisterBloc>(
              create: (context) =>
                  RegisterBloc(authRepository: AuthRepository())),
          BlocProvider<PatientBloc>(create: (context) => PatientBloc()),
          BlocProvider<VaccinationsBloc>(create: (context) => VaccinationsBloc()),
          BlocProvider<UpcomingAppointmenBloc>(
              create: (context) => UpcomingAppointmenBloc()),
          BlocProvider<GetAllRecentReportsBloc>(
              create: (context) => GetAllRecentReportsBloc()),
          BlocProvider<GetPrescriptionBlocBloc>(
              create: (context) => GetPrescriptionBlocBloc()),
          BlocProvider<MedilineBloc>(create: (context) => MedilineBloc()),
          BlocProvider<MedilineSearchBloc>(
              create: (context) => MedilineSearchBloc()),
          BlocProvider<AppointmentBloc>(
              create: (context) => AppointmentBloc(
                  appointmentRepository: AppointmentRepository())),
          BlocProvider<MyPrescriptionBloc>(
              create: (context) => MyPrescriptionBloc()),
          BlocProvider<PreviousReportBloc>(
              create: (context) => PreviousReportBloc()),
          BlocProvider<GetAllClinicBloc>(create: (context) => GetAllClinicBloc()),
          BlocProvider<GetPrescriptionCliicWiseBloc>(
              create: (context) => GetPrescriptionCliicWiseBloc()),
          BlocProvider<SharedFilesBloc>(create: (context) => SharedFilesBloc()),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
          BlocProvider<PatientBloc>(create: (context) => PatientBloc()),
          BlocProvider<NotificationBloc>(create: (context) => NotificationBloc()),
          BlocProvider<UpdatePatientBloc>(
              create: (context) => UpdatePatientBloc()),
          BlocProvider<FaqBloc>(create: (context) => FaqBloc())
        ],
        child: MaterialApp(
          title: 'Jayta Patient',
          debugShowCheckedModeBanner: false,
          theme: ThemeConstants.mainTheme,
          home: !sharedPrefs.onboarded!
              ? const MainOnboarding()
              : sharedPrefs.authToken == ''
                  ? const LoginScreen()
                  : const MyJatya(),
        ),
      ),
    );
  }
}
