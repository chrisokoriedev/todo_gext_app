import 'package:flutter/material.dart';
import 'package:todo_gext_app/app/core/value/icons.dart';

import '../core/value/colors.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon), color: purple),
    Icon(IconData(workIcon), color: pinkColor),
    Icon(IconData(movieIcon), color: green),
    Icon(IconData(sportIcon), color: yellow),
    Icon(IconData(travelIcon), color: deepPink),
    Icon(IconData(shopIcon), color: lightBlue)
  ];
}
