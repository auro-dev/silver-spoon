import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:platemate_user/global_controllers/user_controller.dart';
import 'package:platemate_user/pages/dashboard/dashboard_page.dart';
import 'package:platemate_user/utils/check_permissions.dart';
import 'package:platemate_user/utils/dialog_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:collection/collection.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

///
/// Created by Auro on 03/05/23 at 8:33 PM
///

class CurrentLocationPicker extends StatelessWidget {
  const CurrentLocationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentLocationNotifier,
      builder: (c, v, _) => GestureDetector(
        onTap: setCurrentLocation,
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: Color(0xff333333),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                currentLocationNotifier.value.isEmpty
                    ? "Fetching Location..."
                    : "${SharedPreferenceHelper.city}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.grey20,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                Icons.arrow_drop_down,
                color: AppColors.grey20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _checkLocationPermission() async {
  final serviceStatus = await ph.Permission.locationWhenInUse.serviceStatus;
  final isGpsOn = serviceStatus == ph.ServiceStatus.enabled;
  if (!isGpsOn) {
    print('Turn on location services before requesting permission.');
    return;
  }

  final status = await ph.Permission.locationWhenInUse.request();
  if (status == ph.PermissionStatus.granted) {
    print('Permission granted');
  } else if (status == ph.PermissionStatus.denied) {
    print('Permission denied. Show a dialog and again ask for the permission');
  } else if (status == ph.PermissionStatus.permanentlyDenied) {
    print('Take the user to the settings page.');

    showMyDialog(
        title:
            "Location permissions are denied. Go to settings and permit us to get your location.",
        positiveText: "Open settings",
        negativeText: "Cancel",
        positiveCallback: () async {
          await ph.openAppSettings();
        });
  }
}

setCurrentLocation() async {
  try {
    final _geocoding = GoogleMapsGeocoding(apiKey: Environment.mapApiKey);

    await _checkLocationPermission();

    final Position data = await CheckPermissions.getCurrentLocation();
    log("Step 1 :====: ${data}");

    if (Get.isRegistered<UserController>()) {
      final userController = Get.find<UserController>();
      userController.updateCurrentPosition(data);
    }

    final geocodingResult = await _geocoding
        .searchByLocation(Location(lat: data.latitude, lng: data.longitude));

    log("${geocodingResult.results}");
    log("${geocodingResult.errorMessage}");

    final value = geocodingResult.results[0];

    if (value.addressComponents.isNotEmpty) {
      /// --------------------------------- House no
      String _houseNo = "";

      try {
        _houseNo = value.addressComponents
            .firstWhere((element) =>
                ListEquality().equals(element.types, ["street_number"]))
            .longName;
      } catch (err) {}
      //
      // /// --------------------------------- Land mark
      // String _landMark = "";
      // try {
      //   _landMark = value.addressComponents
      //       .firstWhere((element) =>
      //           ListEquality().equals(element.types, ["route"]))
      //       .longName;
      // } catch (err) {}

      /// --------------------------------- Area
      String _area = "";

      try {
        _area = value.addressComponents
            .firstWhere((element) => ListEquality().equals(element.types,
                ["political", "sublocality", "sublocality_level_1"]))
            .longName;
      } catch (err) {}

      /// --------------------------------- City
      String _city = "";

      try {
        _city = value.addressComponents
            .firstWhere((element) =>
                ListEquality().equals(element.types, ["locality", "political"]))
            .longName;
      } catch (err) {}

      /// --------------------------------- State
      String _state = "";

      try {
        _state = value.addressComponents
            .firstWhere((element) => ListEquality().equals(
                element.types, ["administrative_area_level_1", "political"]))
            .longName;
      } catch (err) {}

      String address =
          "${_houseNo.isEmpty ? "" : "$_houseNo, "}${_area.isEmpty ? "" : "$_area, "}${_city.isEmpty ? "" : "$_city, "}${_state.isEmpty ? "" : "$_state. "}";

      log(address);
      currentLocationNotifier.value = _city;
      SharedPreferenceHelper.storeCity(_city);
      // SnackBarHelper.show("Current location updated");
    }
  } catch (err, s) {
    log("$err  $s");
    //SnackBarHelper.show("$err");
  }
}
