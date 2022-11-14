import 'package:firebase_core/firebase_core.dart';
import 'package:noti_test_student/views/home/home_view.dart';
import 'package:noti_test_student/views/new_home/new_home_view.dart';

import 'core/locator.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  await Firebase.initializeApp();
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigatorService>().navigatorKey,
      home: const NewHomeView(),
    );
  }
}
