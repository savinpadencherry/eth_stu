import 'package:logger/logger.dart';
import 'package:noti_test_student/core/services/auth_service.dart';

import '../core/logger.dart';
import '../core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class LocatorInjector {
  static final Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    getIt.registerLazySingleton(() => NavigatorService());
    getIt.registerLazySingleton(() => AuthService());
  }
}
