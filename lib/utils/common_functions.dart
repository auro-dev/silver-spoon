import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as time_ago;
import 'package:url_launcher/url_launcher.dart';

///
/// Created by Sunil Kumar from Boiler plate.
///

/// ui Image from Network image
Future<ui.Image> getImageFromUrlPath(String url, [Size? size]) async {
  final imageFile = NetworkImage(url);
  final Completer<ui.Image> completer = Completer();
  imageFile
      .resolve(ImageConfiguration(size: size ?? Size(150, 150)))
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    if (!completer.isCompleted) completer.complete(info.image);
  }));
  return completer.future;
}

/// ByteList From Asset Image
Future<Uint8List> getBytesFromAsset(String path,
    {int? width, int? height}) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetHeight: height ?? 150, targetWidth: width ?? 150);
  //! optional
  //  targetHeight: height, targetWidth: width
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

/// ByteList From Network image
Future<Uint8List> getBytesFromNetwork(String url) async {
  ui.Image image = await getImageFromUrlPath(url);
  ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
  Uint8List uint8List = byteData.buffer.asUint8List();
  return uint8List;
}

/// Get duration in mm:ss
String getDurationInMinutesAndSeconds(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

String timeInAgoShort(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en_short', allowFromNow: true);
}

String timeInAgoFull(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en', allowFromNow: true);
}

getMonthStringFromInt(int m) {
  String month = '';
  switch (m) {
    case 1:
      month = "January";
      break;
    case 2:
      month = "February";
      break;
    case 3:
      month = "March";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "June";
      break;
    case 7:
      month = "July";
      break;
    case 8:
      month = "August";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "October";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "December";
      break;
  }
  return month;
}

Future<void> openMap(double latitude, double longitude,
    {LaunchMode linkLaunchMode = LaunchMode.externalApplication}) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunchUrl(Uri.parse(googleUrl))) {
    await launchUrl(Uri.parse(googleUrl), mode: linkLaunchMode);
  } else {
    throw 'Could not open the map.';
  }
}
