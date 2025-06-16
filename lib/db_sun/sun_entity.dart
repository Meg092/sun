import 'package:intl/intl.dart';

class SunEntity {
  int id;
  DateTime createdTime;
  String title;
  int type;
  DateTime startTime;
  DateTime endTime;

  SunEntity({
    required this.id,
    required this.createdTime,
    required this.title,
    required this.type,
    required this.startTime,
    required this.endTime,
  });

  factory SunEntity.fromJson(Map<String, dynamic> json) {
    return SunEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      title: json['title'],
      type: json['type'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'title': title,
      'type': type,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  String get startEndTimeStr => '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}';
}