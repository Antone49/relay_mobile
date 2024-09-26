import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/color_constant.dart';

class CustomStateLoading extends StatelessWidget {
  const CustomStateLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCube(
        color: ColorConstant.primary,
        size: 100.0,
      ),
    );
  }
}