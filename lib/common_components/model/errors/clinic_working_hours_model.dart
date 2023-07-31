class ClinicWorkingHour {
  List<Day>? monday;
  List<Day>? tuesday;
  List<Day>? wednesday;
  List<Day>? thursday;
  List<Day>? friday;
  List<Day>? saturday;
  List<Day>? sunday;

  ClinicWorkingHour({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory ClinicWorkingHour.fromJson(Map<String, dynamic> json) =>
      ClinicWorkingHour(
        monday: json["MONDAY"] == null
            ? null
            : List<Day>.from(json["MONDAY"]!.map((x) => Day.fromJson(x))),
        tuesday: json["TUESDAY"] == null
            ? null
            : List<Day>.from(json["TUESDAY"]!.map((x) => Day.fromJson(x))),
        wednesday: json["WEDNESDAY"] == null
            ? null
            : List<Day>.from(json["WEDNESDAY"]!.map((x) => Day.fromJson(x))),
        thursday: json["THURSDAY"] == null
            ? null
            : List<Day>.from(json["THURSDAY"]!.map((x) => Day.fromJson(x))),
        friday: json["FRIDAY"] == null
            ? null
            : List<Day>.from(json["FRIDAY"]!.map((x) => Day.fromJson(x))),
        saturday: json["SATURDAY"] == null
            ? null
            : List<Day>.from(json["SATURDAY"]!.map((x) => Day.fromJson(x))),
        sunday: json["SUNDAY"] == null
            ? null
            : List<Day>.from(json["SUNDAY"]!.map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MONDAY": monday == null
            ? []
            : List<dynamic>.from(monday!.map((x) => x.toJson())),
        "TUESDAY": tuesday == null
            ? []
            : List<dynamic>.from(tuesday!.map((x) => x.toJson())),
        "WEDNESDAY": wednesday == null
            ? []
            : List<dynamic>.from(wednesday!.map((x) => x.toJson())),
        "THURSDAY": thursday == null
            ? []
            : List<dynamic>.from(thursday!.map((x) => x.toJson())),
        "FRIDAY": friday == null
            ? []
            : List<dynamic>.from(friday!.map((x) => x.toJson())),
        "SATURDAY": saturday == null
            ? []
            : List<dynamic>.from(saturday!.map((x) => x.toJson())),
        "SUNDAY": sunday == null
            ? []
            : List<dynamic>.from(sunday!.map((x) => x.toJson())),
      };
}

class Day {
  DateTime openingTime;
  DateTime closingTime;
  Day({
    required this.openingTime,
    required this.closingTime,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        openingTime: DateTime.parse(json["openingTime"]).toLocal(),
        closingTime: DateTime.parse(json["closingTime"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "openingTime": openingTime.toIso8601String(),
        "closingTime": closingTime.toIso8601String(),
      };
}
