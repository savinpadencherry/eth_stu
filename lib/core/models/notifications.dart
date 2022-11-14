// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Notifications extends Equatable {
  final String studentName;
  final String studentUserId;
  final String teacherName;
  final String type;
  final String? message;
  const Notifications({
    required this.studentName,
    required this.studentUserId,
    required this.teacherName,
    required this.type,
    this.message,
  });

  Notifications copyWith({
    String? studentName,
    String? studentUserId,
    String? teacherName,
    String? type,
    String? message,
  }) {
    return Notifications(
      studentName: studentName ?? this.studentName,
      studentUserId: studentUserId ?? this.studentUserId,
      teacherName: teacherName ?? this.teacherName,
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentName': studentName,
      'studentUserId': studentUserId,
      'teacherName': teacherName,
      'type': type,
      'message': message,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      studentName: map['studentName'] as String,
      studentUserId: map['studentUserId'] as String,
      teacherName: map['teacherName'] as String,
      type: map['type'] as String,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      studentName,
      studentUserId,
      teacherName,
      type,
      message,
    ];
  }
}
