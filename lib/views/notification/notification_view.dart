// ignore_for_file: public_member_api_docs, sort_constructors_first
library notification_view;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noti_test_student/core/locator.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:noti_test_student/core/models/notifications.dart';
import 'package:noti_test_student/core/services/auth_service.dart';
import 'package:noti_test_student/widgets/notificationwidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'notification_desktop.dart';
part 'notification_mobile.dart';
part 'notification_tablet.dart';

class NotificationView extends StatelessWidget {
  final UserCredential userCredential;
  const NotificationView({
    Key? key,
    required this.userCredential,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _NotificationMobile(
          userCredential: userCredential,
        ),
        desktop: _NotificationDesktop(),
        tablet: _NotificationTablet(),
      );
    });
  }
}
