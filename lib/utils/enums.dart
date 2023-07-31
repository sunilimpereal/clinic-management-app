enum ImageSelectorType { gallery, camera }

enum SearchTypes { everthing, clinic, doctor, medicine }

extension SearchTypesExtension on SearchTypes {
  String get name {
    switch (this) {
      case SearchTypes.everthing:
        return 'Everything';
      case SearchTypes.clinic:
        return 'Clinic';
      case SearchTypes.doctor:
        return 'Doctor';
      case SearchTypes.medicine:
        return 'Medicine';
      default:
        return 'Everything';
    }
  }
}

enum NotificationActionType {
  appointment,
  prescription,
  sharedFile
}

extension NotificationActionTypeExtension on NotificationActionType {
  String get name {
    switch (this) {
      case NotificationActionType.appointment:
        return "APPOINTMENT";
      case NotificationActionType.prescription:
        return "PRESCRIPTION";
      case NotificationActionType.sharedFile:
        return "SHARED_FILE";
      default:
        return "APPOINTMENT";
    }
  }
}


