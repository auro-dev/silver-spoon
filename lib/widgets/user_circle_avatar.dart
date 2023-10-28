import 'package:cached_network_image/cached_network_image.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class UserCircleAvatar extends StatelessWidget {
  final String? userId;
  final String? name;
  final String? imageUrl;
  final double? radius;

  const UserCircleAvatar(this.imageUrl, {this.userId, this.name, this.radius});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: userId ?? UniqueKey().toString(),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        imageBuilder: (context, provider) => CircleAvatar(
          backgroundImage: provider,
          radius: radius ?? 32,
        ),
        errorWidget: (c, s, d) => AvatarPlaceholder(
          name ?? ' ',
          backgroundColor: Colors.green,
          radius: radius ?? 32,
          textColor: Colors.black,
        ),
        placeholder: (context, url) => AvatarPlaceholder(
          name ?? ' ',
          backgroundColor: Colors.green,
          radius: radius ?? 32,
          textColor: Colors.black,
        ),
      ),
    );
  }
}

class AvatarPlaceholder extends StatelessWidget {
  final String? firstLetter;
  final double? radius;
  final Color? backgroundColor, textColor;

  AvatarPlaceholder(this.firstLetter,
      {this.radius, this.backgroundColor, this.textColor})
      : assert(firstLetter != null, firstLetter?.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(
        "${firstLetter!.substring(0, 1)}",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      radius: radius,
      backgroundColor: Color(0xffD9D9D9),
    );
  }
}
