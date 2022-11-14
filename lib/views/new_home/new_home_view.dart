library new_home_view;

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';
part 'new_home_mobile.dart';
part 'new_home_tablet.dart';
part 'new_home_desktop.dart';

class NewHomeView extends StatelessWidget {
  const NewHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenTypeLayout(
        mobile: _NewHomeMobile(),
        desktop: _NewHomeDesktop(),
        tablet: _NewHomeTablet(),
      );
    });
  }
}
