import 'package:flutter/cupertino.dart';

import '../core/value/colors.dart';

List<Icon> getIcons() {
  return const [
    Icon(CupertinoIcons.person_alt, color: purple),
    Icon(CupertinoIcons.briefcase_fill, color: pinkColor),
    Icon(CupertinoIcons.video_camera_solid, color: green),
    Icon(CupertinoIcons.sportscourt, color: yellow),
    Icon(CupertinoIcons.car, color: deepPink),
    Icon(CupertinoIcons.shopping_cart, color: lightBlue)
  ];
}
