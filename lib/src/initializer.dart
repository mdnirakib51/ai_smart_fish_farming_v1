
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'domain/local/preferences/local_storage.dart';
import 'domain/local/preferences/storage_controller.dart';
import 'domain/server/http_client/request_handler.dart';
import 'features/student_panel/student_dashboard_bottom_navigation_bar/controller/student_dashboard_bottom_controller.dart';
import 'features/student_panel/student_fee_screen/controller/student_fee_controller.dart';
import 'features/student_panel/student_home_screen/controller/student_home_controller.dart';
import 'service/auth/controller/auth_controller.dart';
import 'service/location/controller/location_controller.dart';

final locator = GetIt.instance;

Future<void> init(LocalStorage localStorage) async {

  // ==# Register dependencies with GetIt for core services
  locator.registerLazySingleton<LocalStorage>(() => localStorage);
  locator.registerLazySingleton<RequestHandler>(() => RequestHandler(dio: Dio()));

  Get.put(LocalStorageController());

  // ==# UI Controllers using GetX lazyPut for screen management
  Get.lazyPut(() => LocationController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);

  Get.lazyPut(() => StudentDashboardBottomController(), fenix: true);
  Get.lazyPut(() => StudentHomePageController(), fenix: true);
  Get.lazyPut(() => StudentFeeController(), fenix: true);

  // ==# Register GetIt services within GetX for further access
  Get.lazyPut(() => locator<RequestHandler>(), fenix: true);
  Get.lazyPut(() => locator<LocalStorageController>(), fenix: true);

}