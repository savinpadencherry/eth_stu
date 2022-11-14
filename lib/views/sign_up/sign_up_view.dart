library sign_up_view;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:noti_test_student/core/services/auth_service.dart';
import 'package:noti_test_student/views/home/home_view.dart';
import 'package:noti_test_student/views/login/login_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../core/locator.dart';
import '../../core/services/navigator_service.dart';

part 'sign_up_mobile.dart';
part 'sign_up_tablet.dart';
part 'sign_up_desktop.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _SignUpMobile(),
        desktop: _SignUpDesktop(),
        tablet: _SignUpTablet(),
      );
    });
  }
}
