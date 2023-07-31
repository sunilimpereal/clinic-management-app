import 'package:clinic_app/utils/enums.dart';

class SearchItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageurl;
  final SearchTypes? type;

  SearchItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageurl,
    this.type = SearchTypes.everthing,
  });
}
