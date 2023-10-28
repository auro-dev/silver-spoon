// import 'dart:developer';
// import 'dart:math' as math;
//
// import 'package:flutter_mobile_template/app_configs/environment.dart';
// import 'package:flutter_mobile_template/utils/check_permissions.dart';
// import 'package:flutter_mobile_template/utils/snackbar_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/geocoding.dart';
// import 'package:google_maps_webservice/places.dart';
//
// import 'app_loader.dart';
//
// ///
// /// Created by Sunil Kumar from Boiler plate
// ///
//
// class Uuid {
//   final math.Random _random = math.Random();
//   String generateV4() {
//     // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
//     final int special = 8 + _random.nextInt(4);
//
//     return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
//         '${_bitsDigits(16, 4)}-'
//         '4${_bitsDigits(12, 3)}-'
//         '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
//         '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
//   }
//
//   String _bitsDigits(int bitCount, int digitCount) =>
//       _printDigits(_generateBits(bitCount), digitCount);
//
//   int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);
//
//   String _printDigits(int value, int count) =>
//       value.toRadixString(16).padLeft(count, '0');
// }
//
// class PlacePicker extends PlacesAutocompleteWidget {
//   final String title;
//
//   PlacePicker({this.title = 'Detect my location'})
//       : super(
//             apiKey: Environment.mapApiKey,
//             sessionToken: Uuid().generateV4(),
//             language: "en",
//             debounce: 0);
//
//   @override
//   _PlacePickerState createState() => _PlacePickerState(title);
// }
//
// class _PlacePickerState extends PlacesAutocompleteState {
//   final String title;
//   _PlacePickerState(this.title);
//   late GoogleMapsGeocoding _geocoding;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _geocoding = GoogleMapsGeocoding(apiKey: Environment.mapApiKey);
//   }
//
//   @override
//   void dispose() {
//     _geocoding.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final appBar = AppBar(
//       title: AppBarPlacesAutoCompleteTextField(),
//       backgroundColor: Colors.white,
//       leading: BackButton(color: Colors.black),
//     );
//     final body = Column(children: [
//       ListTile(
//         leading: Icon(Icons.location_on_rounded,
//             color: theme.primaryColor, size: 32),
//         title: Text('$title'),
//         onTap: () async {
//           FocusScope.of(context).unfocus();
//           Navigator.push(context, LoaderOverlay());
//           try {
//             final Position data = await CheckPermissions.getCurrentLocation();
//
//             final geocodingResult = await _geocoding.searchByLocation(
//                 Location(lat: data.latitude, lng: data.longitude));
//             Navigator.pop(context);
//             Navigator.pop(context, geocodingResult.results[0]);
//           } catch (e) {
//             Navigator.pop(context);
//             SnackBarHelper.show('Error', e.toString());
//           }
//         },
//       ),
//       Expanded(
//         child: PlacesAutocompleteResult(
//           onTap: (p) {
//             displayPrediction(p);
//           },
//           logo: Center(
//             heightFactor: 20,
//             child: Text('Search for a location',
//                 style: Theme.of(context).textTheme.headline6),
//           ),
//         ),
//       )
//     ]);
//     return Scaffold(appBar: appBar, body: body);
//   }
//
//   @override
//   void onResponseError(PlacesAutocompleteResponse response) {
//     super.onResponseError(response);
//     SnackBarHelper.show('Error', response.errorMessage!);
//   }
//
//   // @override
//   // void onResponse(PlacesAutocompleteResponse response) {
//   //   super.onResponse(response);
//   // }
//
//   Future<Null> displayPrediction(Prediction? p) async {
//     if (p != null) {
//       try {
//         FocusScope.of(context).unfocus();
//         Navigator.push(context, LoaderOverlay());
//         final geocodingResult = await _geocoding.searchByPlaceId(
//           p.placeId!,
//         );
//         Navigator.pop(context);
//         Navigator.pop(context, geocodingResult.results[0]);
//       } catch (e, s) {
//         log('$e $s');
//         Navigator.pop(context);
//         SnackBarHelper.show('Error', e.toString());
//       }
//     }
//   }
// }
