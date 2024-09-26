import 'package:flutter/material.dart';

import '../../../../core/theme/app_style.dart';

class CustomCircleNumber extends StatelessWidget {
  final int number;
  final Color color;

  const CustomCircleNumber(this.number, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          number.toString(),
          textAlign: TextAlign.center,
          style: AppStyle.fontBackgroundColor12,
        ),
      ),
    );
  }
}