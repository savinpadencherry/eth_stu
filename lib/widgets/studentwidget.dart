// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:noti_test_student/core/locator.dart';
import 'package:noti_test_student/core/models/notifications.dart';
import 'package:noti_test_student/core/models/student.dart';
import 'package:noti_test_student/core/services/auth_service.dart';
import 'package:noti_test_student/core/services/navigator_service.dart';

class StudentWidget extends StatefulWidget {
  final Student student;
  final Notifications notification;
  const StudentWidget({
    Key? key,
    required this.student,
    required this.notification,
  }) : super(key: key);

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) {
                getIt<AuthService>().putTheNotificationInTheShareuserFeed(
                  student: widget.student,
                  notifications: widget.notification,
                );
                getIt<NavigatorService>().pop();
              },
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),
        child: ListTile(
          dense: true,
          tileColor: CupertinoColors.secondarySystemFill,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(widget.student.email!),
          subtitle: Text(widget.student.userId),
        ),
      ),
    );
  }
}
