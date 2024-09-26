import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_style.dart';
import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/size_utils.dart';
import 'custom_button.dart';

class CustomDialogField {
  CustomDialogField({
    required this.context,
    required this.title,
    required this.children,
    required this.onCancel,
    required this.onOk});

  BuildContext context;
  String title;
  List<Widget> children;
  VoidCallback? onCancel;
  VoidCallback? onOk;

  show() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Column(mainAxisSize: MainAxisSize.min, children: children),
            actions: <Widget>[
              CustomButton(
                text: "lbl_cancel".tr,
                height: getVerticalSize(30),
                width: getHorizontalSize(75),
                color: ColorConstant.incorrect,
                textStyle: AppStyle.fontBackgroundColor16,
                onTap: onCancel,
              ),
              CustomButton(
                text: "lbl_ok".tr,
                height: getVerticalSize(30),
                width: getHorizontalSize(75),
                textStyle: AppStyle.fontBackgroundColor16,
                onTap: onOk,
              ),
            ],
          );
        });
  }
}
