import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_style.dart';
import '../../../../core/utils/image_constant.dart';
import '../../../../core/utils/size_utils.dart';
import 'custom_button.dart';
import 'custom_image_view.dart';

enum AlertType { error, success, info, warning, none }

class CustomDialogAlert {
  CustomDialogAlert({
    required this.context,
    required this.type,
    required this.message,
    this.onClose});

  BuildContext context;
  AlertType type;
  String message;
  VoidCallback? onClose;

  show() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: _getTitle(),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getImage(),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: AppStyle.fontBlack16,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: <Widget>[
              CustomButton(
                text: "lbl_ok".tr,
                height: getVerticalSize(30),
                width: getHorizontalSize(75),
                textStyle: AppStyle.fontBackgroundColor16,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }).then((val){
          if(onClose != null) {
            onClose!();
          }
        });
  }

  Widget _getTitle() {
    Widget response;
    switch (type) {
      case AlertType.success:
        response = Text(
          "lbl_success".tr,
          style: AppStyle.fontBlack20,
        );
        break;
      case AlertType.error:
        response = Text(
          "lbl_error".tr,
          style: AppStyle.fontBlack20,
        );
        break;
      case AlertType.info:
        response = Text(
          "lbl_info".tr,
          style: AppStyle.fontBlack20,
        );
        break;
      case AlertType.warning:
        response = Text(
          "lbl_warning".tr,
          style: AppStyle.fontBlack20,
        );
        break;
      case AlertType.none:
      default:
        response = Container();
        break;
    }
    return response;
  }

  Widget _getImage() {
    Widget response;
    switch (type) {
      case AlertType.success:
        response = CustomImageView(
          svgPath: ImageConstant.imgCorrect,
          height: getVerticalSize(100),
          width: getHorizontalSize(100),
        );
        break;
      case AlertType.error:
        response = CustomImageView(
          svgPath: ImageConstant.imgError,
          height: getVerticalSize(100),
          width: getHorizontalSize(100),
        );
        break;
      case AlertType.info:
        response = CustomImageView(
          svgPath: ImageConstant.imgInformation,
          height: getVerticalSize(100),
          width: getHorizontalSize(100),
        );
        break;
      case AlertType.warning:
        response = CustomImageView(
          svgPath: ImageConstant.imgWarning,
          height: getVerticalSize(100),
          width: getHorizontalSize(100),
        );
        break;
      case AlertType.none:
      default:
        response = Container();
        break;
    }
    return response;
  }
}
