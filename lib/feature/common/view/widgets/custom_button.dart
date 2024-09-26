import 'package:flutter/material.dart';

import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/size_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.textStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.isLoading,
      this.color,
      });

  final Color? color;
  final TextStyle? textStyle;
  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final String? text;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButton(),
      ),
    );
  }

  _buildButton() {
    if(isLoading != null && isLoading == true){
      return const CircularProgressIndicator(color: ColorConstant.backgroundColor);
    }

    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: _setFontStyle(),
      maxLines: 1,
    );
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      backgroundColor: _setColor(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setColor() {
    return color ?? ColorConstant.primary;
  }

  _setBorderRadius() {
    return BorderRadius.circular(
      getHorizontalSize(
        25.00,
      ),
    );
  }

  _setFontStyle() {
    return textStyle;
  }
}
