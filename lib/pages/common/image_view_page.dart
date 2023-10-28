import 'package:platemate_user/widgets/my_image.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 30/12/22 at 12:11 AM
///

class ImageViewPage extends StatefulWidget {
  final String url;

  const ImageViewPage({Key? key, this.url = ''}) : super(key: key);

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: "${widget.url}",
          child: MyImage(widget.url),
        ),
      ),
    );
  }
}
