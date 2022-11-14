// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  final String? email;
  final String userId;
  const Teacher({
    required this.email,
    required this.userId,
  });

  Teacher copyWith({
    String? email,
    String? userId,
  }) {
    return Teacher(
      email: email ?? this.email,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'userId': userId,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      email: map['email'] != null ? map['email'] as String : null,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, userId];
}
