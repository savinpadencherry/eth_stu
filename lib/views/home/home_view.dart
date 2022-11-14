// ignore_for_file: public_member_api_docs, sort_constructors_first
library home_view;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:noti_test_student/views/notification/notification_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'home_desktop.dart';
part 'home_mobile.dart';
part 'home_tablet.dart';

class HomeView extends StatelessWidget {
  final UserCredential userCredential;
  const HomeView({
    Key? key,
    required this.userCredential,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _HomeMobile(
          userCredential: userCredential,
        ),
        desktop: _HomeDesktop(),
        tablet: const _HomeTablet(),
      );
    });
  }
}
