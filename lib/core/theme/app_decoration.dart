import 'package:flutter/material.dart';
import '../utils/color_constant.dart';
import '../utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get fillGrayLight => const BoxDecoration(
    color: ColorConstant.grayLight,
  );
}

class BorderRadiusStyle {
  static BorderRadius circularBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10,
    ),
  );

  static BorderRadius circularBorder15 = BorderRadius.circular(
    getHorizontalSize(
      15,
    ),
  );

  static BorderRadius circularBorder20 = BorderRadius.circular(
    getHorizontalSize(
      20,
    ),
  );
}
