// ignore_for_file: public_member_api_docs, sort_constructors_first
library share_page_view;

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:noti_test_student/core/locator.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:noti_test_student/core/models/notifications.dart';
import 'package:noti_test_student/core/models/student.dart';
import 'package:noti_test_student/core/services/auth_service.dart';
import 'package:noti_test_student/widgets/studentwidget.dart';

part 'share_page_desktop.dart';
part 'share_page_mobile.dart';
part 'share_page_tablet.dart';

class SharePageView extends StatelessWidget {
  final Notifications notifications;
  const SharePageView({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _SharePageMobile(
          notification: notifications,
        ),
        desktop: _SharePageDesktop(),
        tablet: _SharePageTablet(),
      );
    });
  }
}
