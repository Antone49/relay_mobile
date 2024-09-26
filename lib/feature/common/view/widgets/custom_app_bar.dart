import 'package:flutter/material.dart';

import '../../../../core/utils/color_constant.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(String title, {super.key}) : super(
    backgroundColor: ColorConstant.primary,
    title: Text(title),
    elevation: 0,
  );
}
