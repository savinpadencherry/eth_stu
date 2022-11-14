// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:noti_test_student/core/locator.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:noti_test_student/core/models/notifications.dart';
import 'package:noti_test_student/core/services/navigator_service.dart';
import 'package:noti_test_student/views/share_page/share_page_view.dart';

class NotificationWidget extends StatefulWidget {
  final Notifications notification;
  const NotificationWidget({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> with LogMixin {
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
                warningLog('message');
                getIt<NavigatorService>().buildAndPush(
                    SharePageView(notifications: widget.notification));
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
            tileColor: widget.notification.type == 'Solo'
                ? CupertinoColors.systemRed
                : CupertinoColors.secondarySystemFill,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(widget.notification.teacherName),
            subtitle: Text('${widget.notification.message}')),
      ),
    );
  }
}
