class ApiConstants {
  static const String _baseUrl =
      "http://ec2-3-7-6-12.ap-south-1.compute.amazonaws.com:3000/api/v1";
  static const String _baseUrlS3 =
      "http://ec2-3-7-6-12.ap-south-1.compute.amazonaws.com:3000/s3";

  // auth
  static String login = "$_baseUrl/auth/login";
  static String refresh = "$_baseUrl/auth/refresh";
  static String loginPhone = "$_baseUrl/auth/login/phone";
  static String loginPhoneMfa = "$_baseUrl/auth/login/mfa/phone";
  static String forgotPassword = "$_baseUrl/auth/forgotPassword";
  static String verifyForgotPassword = "$_baseUrl/auth/forgotPassword/verify";
  static String register = "$_baseUrl/user";
  static String registerVerify = "$_baseUrl/user/verify";
  static String deleteUser = "$_baseUrl/user";
  static String deleteUserData = "$_baseUrl/auth";

  //social media
  static String googleLogin = "$_baseUrl/auth/google/login";
  static String googleRedirect = "$_baseUrl/auth/google/redirect";
  static String facebookLogin = "$_baseUrl/auth/facebook/login";
  static String facebookRedirect = "$_baseUrl/auth/facebook/redirect";
  static String twitterLogin = "$_baseUrl/auth/linkedin/login";
  static String twitter = "$_baseUrl/auth/linkedin/redirect";
  static String linkedinRedirect = "$_baseUrl/auth/linkedin/redirect";

  // new appointment
  static String appointment = "$_baseUrl/appointment";
  static String specialisation = "$_baseUrl/specialisation";

  //Getting a Specific patient
  static String specificPatient = "$_baseUrl/patient";

// getting patient Id
  static String getPatientByuid = "$_baseUrl/patient/user-id";

  //Update Patient Data
  static String updatePatient = "$_baseUrl/patient";

  //getting allergies
  static String allergy = "$_baseUrl/allergy";

  // get vaccination
  static String vaccination = "$_baseUrl/vaccination";
  static String uploadReport = "$_baseUrlS3/files/upload/reports";

  // get getPrevReport
  static String getPrevReport = "$_baseUrl/patientReport";
  static String prevReport = "$_baseUrl/patientReport";

  // shareReportWithDoc
  static String shareReport = "$_baseUrl/shareReport/shareReport";
  static String revokeReport = "$_baseUrl/shareReport";
  // get all Notifications
  static String getAllNotifications = "$_baseUrl/notification?";
  static String getNotificationDetails = "$_baseUrl/notification";

  //undo all notifications
  static String undoAllNotifications = "$_baseUrl/notification";

  //read all notifications
  static String readAllNotifications = "$_baseUrl/notification";

  //get all appointments
  static String getAllAppointments = "$_baseUrl/appointment?";

  //get Specific appointments
  static String getSpecificAppointments = "$_baseUrl/appointment/";

  //get all prescriptions
  static String getAllPresciriptions = "$_baseUrl/prescriptions";

  //download prescription
  static String downloadPrescription = "$_baseUrl/prescriptions/download/";
  static String downloadPrescriptionPdf = "$_baseUrl/pdf/prescription";
  //cancel appointment
  static String cancelAppointments = "$_baseUrl/appointment/";

  static String getClinic = "$_baseUrl/clinic?";
  static String shareAppointments =
      "$_baseUrl/shared-appointment";
  static String revokeAppointments = "$_baseUrl/shared-appointment";
  static String shareMediline = "$_baseUrl/appointment/shareMediline";
  static String revokeMediline = shareMediline;
  //doctors
  static String geoLocationDoctors = "$_baseUrl/doctor/geo-location?";
  static String doctorDetail = "$_baseUrl/doctor";

  //slots
  static String slots = "$_baseUrl/doctor/slots";
  static String clinic = "$_baseUrl/clinic";

  // user
  static String userUpdate = "$_baseUrl/user";

  static String uploadProfileUrl = "$_baseUrlS3/files/upload/profile";
  static String shareAppointmentToClinic = "$_baseUrl/appointmentClinic";
  static String sharedFilesByUser = "$_baseUrl/shareReport/sharedFiles";

  // Recently Visited Clinic
  static String getAllVisitedClinic =
      "$_baseUrl/patient/recentlyVisitedClinics/";

  //Share Prescription
  static String sharePrescription =
      "$_baseUrl/prescriptions/sharedPrescription";
  static String revokePrescription =
      "$_baseUrl/prescriptions/sharedPrescription";

  static String getFaq = '$_baseUrl/faqs';
}
