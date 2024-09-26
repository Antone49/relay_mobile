import 'package:flutter/material.dart';

import '../../../../core/utils/color_constant.dart';
import 'custom_text_form_field.dart';

class CustomTextPasswordField extends StatefulWidget {
  const CustomTextPasswordField({
    super.key,
    required this.controller,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.fillColor,
  });

  final String? hintText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Color? fillColor;

  @override
  CustomTextPasswordFieldState createState() => CustomTextPasswordFieldState();
}

class CustomTextPasswordFieldState extends State<CustomTextPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      hintText: widget.hintText,
      fillColor: widget.fillColor,
      suffix: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: ColorConstant.primary,
              size: 20,
          ),
        ),
    );
  }
}