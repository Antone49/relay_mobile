import 'package:flutter/material.dart';

import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_style.dart';
import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.validator,
      this.fillColor});

  final double? width;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final Color? fillColor;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: AppStyle.fontBlack14,
        obscureText: obscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: AppStyle.fontBlack14,
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: fillColor ?? ColorConstant.grayLight,
      filled: true,
      isDense: true,
      contentPadding: getPadding(
        all: 11,
      ),
    );
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadiusStyle.circularBorder20,
      borderSide: BorderSide.none,
    );
  }
}
