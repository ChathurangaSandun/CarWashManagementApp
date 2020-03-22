import 'model.dart';

class NotificationModel {
  final int id;
  final String title;
  final String subtitle;
  final String date;
  final CategoryModel category;

  NotificationModel(
    this.id,
    this.title,
    this.subtitle,
    this.date,
    this.category,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      json['id'] as int,
      json['title'] as String,
      json['subtitle'] as String,
      json['date'] as String,
      new CategoryModel.fromJson(json['category']),
    );
  }
}
