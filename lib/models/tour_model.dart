import 'activity_model.dart';

class Tour {
  final int id;
  final String title;
  final String imagesUrl;
  final String desc;
  final String city;
  final String country;
  int price;

  List<Activity> activities;

  Tour(
      {this.id,
      this.title,
      this.imagesUrl,
      this.desc,
      this.city,
      this.country,
      this.activities,
      this.price});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      title: json['title'],
      imagesUrl: json['imagesUrl'],
    );
  }
}