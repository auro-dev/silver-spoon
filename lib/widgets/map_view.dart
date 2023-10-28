import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

///
/// Created by Auro on 19/05/22 at 5:04 pm
///

class MyMapView extends StatefulWidget {
  final Map<String, dynamic>? address;
  final VoidCallback? onProceed;
  final Function(LatLng v)? onPositionChanged;

  const MyMapView({this.address, this.onProceed, this.onPositionChanged});

  @override
  State<MyMapView> createState() => _MyMapViewState();
}

class _MyMapViewState extends State<MyMapView> {
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _currentPosition;
  final Map<MarkerId, Marker> _markers = Map<MarkerId, Marker>();

  MarkerId sourceId = MarkerId("SourcePin");

  Map<String, dynamic> get address => widget.address ?? {};

  Future<ui.Image> getImageFromPath() async {
    final imageFile = NetworkImage(
      'https://i.imgur.com/9OWQq7Z.png',
    );
    final Completer<ui.Image> completer = Completer();
    imageFile
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      if (!completer.isCompleted) completer.complete(info.image);
    }));
    return completer.future;
  }

  setMarkers(LatLng latLng, double rotation, double radius) async {
    final Size size = Size(200, 200);
    ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    Canvas canvas = Canvas(pictureRecorder);
//      final double shadowWidth = 15.0;
//      final double borderWidth = 3.0;

//      final double imageOffset = shadowWidth + borderWidth;
    Paint paint = Paint()..color = AppColors.brightPrimary.withOpacity(0.1);

    /// Marker
//    final path = Path()
//      ..moveTo(size.width / 2, size.height)
//      ..cubicTo(-12, size.height / 2 + 8, 0, 0, size.width / 2, 0)
//      ..cubicTo(size.width, 0, size.width + 12, size.height / 2 + 8,
//          size.width / 2, size.height);
    final path = Path();

    /// yellow circle
    // canvas.drawOval(
    //   Rect.fromLTWH(0, 0, size.width + radius, size.height + radius),
    //   paint,
    // );
    // canvas.drawShadow(path, Colors.grey, 4, true);

    /// to draw image marker from network image
    Rect rect = Rect.fromLTWH(radius / 2, radius / 2, size.width, size.height);
    ui.Image image = await getImageFromPath();
    paintImage(
      canvas: canvas,
      image: image,
      rect: rect,
      fit: BoxFit.contain,
    );

    /// Convert canvas to image
    ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt() + radius.toInt(),
        size.height.toInt() + radius.toInt());

    /// Convert image to bytes
    ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8List = byteData!.buffer.asUint8List();

    _markers[sourceId] = Marker(
        markerId: sourceId,
        visible: true,
        icon: BitmapDescriptor.fromBytes(uint8List),
        position: latLng,
        rotation: rotation,
        anchor: Offset(0.5, 0.5),
        onDragEnd: (newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
          // setMarkers(
          //   LatLng(
          //     newPosition.latitude,
          //     newPosition.longitude,
          //   ),
          //   0,
          //   80,
          // );
          widget.onPositionChanged!.call(newPosition);
        },
        infoWindow: InfoWindow(title: 'You'));
    _currentPosition = CameraPosition(target: latLng, zoom: 15);
    setState(() {});
  }

  @override
  void didUpdateWidget(MyMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _currentPosition = CameraPosition(
    //   target: LatLng(
    //     address["latitudes"] ?? 0,
    //     address["longitude"] ?? 0,
    //   ),
    //   zoom: 14.4746,
    // );
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    log("INITIALIZING GOOGLE MAPS ::::: WITH : $address");
    _currentPosition = CameraPosition(
      target: LatLng(
        address["latitudes"] ?? 0,
        address["longitude"] ?? 0,
      ),
      zoom: 13.4746,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return address["latitudes"] == null || address["latitudes"] == null
        ? Center(
            child: Text("Unable to fetch exact location"),
          )
        : GoogleMap(
            onTap: (v) {
              log("$v");
              setMarkers(
                LatLng(
                  v.latitude,
                  v.longitude,
                ),
                0,
                80,
              );
              widget.onPositionChanged!.call(v);
            },
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers.values),
            initialCameraPosition: _currentPosition,
            onCameraMove: (v) {
              log("camera moved :: $v");
              setMarkers(
                LatLng(
                  v.target.latitude,
                  v.target.longitude,
                ),
                0,
                80,
              );
              widget.onPositionChanged!
                  .call(LatLng(v.target.latitude, v.target.longitude));
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setMarkers(
                LatLng(
                  address["latitudes"],
                  address["longitude"],
                ),
                0,
                80,
              );
            },
          );
  }
}
