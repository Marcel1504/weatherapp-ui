import 'package:flutter/material.dart';

class AppLayoutService {
  double betweenItemPadding() {
    return 10;
  }

  double maxWidth() {
    return 750;
  }

  Image getImageAsset(BuildContext context, String name) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    String mode;
    if (brightness == Brightness.dark) {
      mode = "dark";
    } else {
      mode = "light";
    }
    return Image.asset("assets/images/$name-$mode.png");
  }
}
