import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:platemate_user/utils/snackbar_helper.dart';
import '../../app_configs/app_decorations.dart';
import '../../app_configs/app_validators.dart';
import '../../app_configs/environment.dart';
import '../../utils/check_permissions.dart';
import '../../utils/dialog_helper.dart';
import '../../widgets/app_buttons/app_primary_button.dart';
import '../../widgets/map_view.dart';

///
/// Created by Auro on 07/03/23 at 3:04 PM
///

class CreateFootPrintsPage extends StatefulWidget {
  static const routeName = '/create-footprint-page';

  const CreateFootPrintsPage({Key? key}) : super(key: key);

  @override
  State<CreateFootPrintsPage> createState() => _CreateFootPrintsPageState();
}

class _CreateFootPrintsPageState extends State<CreateFootPrintsPage> {
  LatLng? latLangData;
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  TextEditingController textEditingController = TextEditingController();

  // CitySelectionController? controller;
  bool _loading = false;

  Future<void> _checkPermission() async {
    final serviceStatus = await ph.Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ph.ServiceStatus.enabled;
    if (!isGpsOn) {
      throw ('Turn on location services before requesting permission.');
      //return;
    }

    final status = await ph.Permission.locationWhenInUse.request();
    if (status == ph.PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == ph.PermissionStatus.denied) {
      throw ('Permission denied.');
      // showSmartDialog(
      //     title:
      //         "Location permissions are denied. Go to settings and permit us to get your location.",
      //     positiveText: "Open settings",
      //     negativeText: "Cancel",
      //     positiveCallback: () async {
      //       await ph.openAppSettings();
      //     });
    } else if (status == ph.PermissionStatus.permanentlyDenied) {
      //throw('Take the user to the settings page.');

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

  getCurrentLocation() async {
    try {
      setState(() {
        _loading = true;
      });
      await _checkPermission();

      final tempData = await CheckPermissions.getCurrentLocation();
      log("Current Location ::: $tempData");
      latLangData = LatLng(tempData.latitude, tempData.longitude);
      setState(() {
        _loading = false;
      });
    } catch (err) {
      setState(() {
        _loading = false;
      });
      log("CURRENT LOCATION GET ERROR ::: $err");
      //SnackBarHelper.show("$err");
    }
  }

  void updatePosition(LatLng _position) {
    latLangData = LatLng(_position.latitude, _position.longitude);
    log("-----${_position}");
    setState(() {});

    // LatLng newMarkerPosition =
    //     LatLng(_position.target.latitude, _position.target.longitude);
    // Marker marker = markers["1"];
    //
    // markers["1"] = marker.copyWith(
    //     positionParam:
    //         LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Footprint Page"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  // const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Kou jaga kire?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.borderColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: textEditingController,
                      // initialValue: widget.address,
                      // onChanged: onAddressSaved,
                      // onSaved: onAddressSaved,
                      minLines: 3,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (data) =>
                          AppFormValidators.validateEmpty(data, context),
                      decoration: AppDecorations.textFieldDecoration_2(context)
                          .copyWith(
                        hintText: "Bhala se bujhiki lekh jaga name ta",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Preview of your location",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.borderColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  IgnorePointer(
                    ignoring: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 400,
                          child: _loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      // color: Colors.white,
                                      ))
                              : MyMapView(
                                  onPositionChanged: updatePosition,
                                  address: {
                                    "latitudes": latLangData == null
                                        ? Environment.defaultCoordinates[0]
                                        : latLangData!.latitude,
                                    "longitude": latLangData == null
                                        ? Environment.defaultCoordinates[1]
                                        : latLangData!.longitude,
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: _loading
                  ? SizedBox()
                  : SizedBox(
                      width: double.infinity,
                      child: AppPrimaryButton(
                        key: buttonKey,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (textEditingController.text.isEmpty) {
                            SnackBarHelper.show("Name is required");
                            return;
                          }
                          if (latLangData == null) {
                            SnackBarHelper.show(
                              "Issue is getting the coordinates. Check You have added the permission or not",
                            );
                            return;
                          }
                          try {
                            log("${textEditingController.text} :: ${latLangData!.longitude}, ${latLangData!.latitude}");
                            buttonKey.currentState!.showLoader();
                            await ApiCall.post(ApiRoutes.city, body: {
                              "name": textEditingController.text,
                              "coordinates": [
                                latLangData!.longitude,
                                latLangData!.latitude,
                              ]
                            });
                            buttonKey.currentState!.hideLoader();
                            SnackBarHelper.show("Foot print created.");
                          } catch (err) {
                            buttonKey.currentState!.hideLoader();
                            SnackBarHelper.show("$err");
                          }
                        },
                      ),
                    ),
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
