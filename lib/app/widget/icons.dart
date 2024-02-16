import 'package:flutter/cupertino.dart';

import '../core/value/colors.dart';

List<Icon> getIcons() {
  return const [
    Icon(CupertinoIcons.person, color: purple),
    Icon(CupertinoIcons.briefcase, color: pinkColor),
    Icon(CupertinoIcons.video_camera, color: green),
    Icon(CupertinoIcons.sportscourt, color: yellow),
    Icon(CupertinoIcons.car, color: deepPink),
    Icon(CupertinoIcons.cart, color: lightBlue)
  ];
}
