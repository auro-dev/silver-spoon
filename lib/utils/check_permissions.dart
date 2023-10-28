// import 'package:geolocation/geolocation.dart';

// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermissions {
  //Check contacts permission
  static Future<PermissionStatus> getContactPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;

    /// && permission != PermissionStatus.denied
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.permanentlyDenied;
    } else {
      return permission;
    }
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("---request permission");
      //permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    return await Geolocator.getCurrentPosition();
  }

// static Future requestGpsService() async {
//   try {
//     GeolocationResult result = await Geolocation.enableLocationServices();
//     if (result == null || !result.isSuccessful) {
//       throw 'Please Enable GPS to continue';
//     }
//   } catch (e) {
//     throw 'Please Enable GPS to continue';
//   }
// }

// static Future<l.LocationData> requestLocation() async {
//   if (Platform.isIOS) {
//     final GeolocationResult result =
//         await Geolocation.requestLocationPermission(
//       permission: LocationPermission(
//         ios: LocationPermissionIOS.always,
//       ),
//       openSettingsIfDenied: true,
//     );
//     if (result.isSuccessful) {
//       return getLocation();
//     } else {
//       switch (result.error.type) {
//         case GeolocationResultErrorType.serviceDisabled:
//           throw 'Please Enable GPS to continue';
//         case GeolocationResultErrorType.locationNotFound:
//           throw 'Unable to get your location';
//         case GeolocationResultErrorType.permissionDenied:
//           throw 'Please Allow Location permission to continue';
//         case GeolocationResultErrorType.playServicesUnavailable:
//           throw 'Install play services in your phone to continue';
//         case GeolocationResultErrorType.permissionNotGranted:
//           throw 'Please Allow Location permission to continue';
//         default:
//           throw 'Please Allow Location permission to continue';
//       }
//     }
//   } else {
//   var result = await Permission.location.request();
//   if (result.isGranted) {
//     await requestGpsService();
//     return getLocation();
//   }
//   if (result.isDenied) {
//     throw 'Please Allow Location permission to continue';
//   }
//   if (result.isPermanentlyDenied) {
//     throw 'Please Allow Location permission in app settings to continue';
//     // AppSettings.openAppSettings();
//   }
//   }
//   throw 'Please Allow Location permission to continue';
// }

// static Future<l.LocationData> getLocation() async {
//   l.Location location = l.Location();
//   var loc = await location.getLocation().timeout(Duration(seconds: 10),
//       onTimeout: () {
//     throw 'Unable to fetch your location';
//   });
//   return loc;
// }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
//   static Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//
//   static Future<bool> storagePermission() async {
//     var status = await Permission.storage.status;
//     if (status.isGranted) {
//       return true;
//     } else if (status.isDenied || status.isPermanentlyDenied) {
//       var result = await Permission.storage.request();
//       if (result.isDenied) {
//         return false;
//       } else {
//         return true;
//       }
//     } else {
//       return false;
//     }
//   }
}
