import 'package:get/get.dart';

///
/// Created by Auro on 22/11/22 at 11:41 PM
///

class CentralizedLoadingController extends GetxController {
  bool addLoading = false;

  showAddLoading() {
    addLoading = true;
    update();
  }

  hideAddLoading() {
    addLoading = false;
    update();
  }
}
