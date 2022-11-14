library login_view;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:noti_test_student/core/services/auth_service.dart';
import 'package:noti_test_student/core/services/navigator_service.dart';
import 'package:noti_test_student/views/home/home_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../core/locator.dart';

part 'login_mobile.dart';
part 'login_tablet.dart';
part 'login_desktop.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _LoginMobile(),
        desktop: _LoginDesktop(),
        tablet: _LoginTablet(),
      );
    });
  }
}
