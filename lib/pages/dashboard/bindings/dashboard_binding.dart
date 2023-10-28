import 'package:platemate_user/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
