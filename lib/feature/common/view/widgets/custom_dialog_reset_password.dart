import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/validation_functions.dart';
import 'custom_dialog_alert.dart';
import 'custom_dialog_field.dart';
import 'custom_text_form_field.dart';
import 'custom_text_password_field.dart';

class CustomDialogResetPassword {
  CustomDialogResetPassword({
    required this.context,
    required this.email,
    required this.token,
    required this.password,
    required this.onCancel,
    required this.onOk});

  BuildContext context;
  VoidCallback onCancel;
  VoidCallback onOk;
  final String email;
  final TextEditingController token;
  final TextEditingController password;
  final TextEditingController passwordConfirm = TextEditingController();

  show() {
    return CustomDialogAlert(
      context: context,
      type: AlertType.info,
      message: "${"lbl_password_email_sent".tr} $email",
      onClose: changePassword(),
    ).show();
  }

  changePassword() {
    CustomDialogField(
      context: context,
      title: "lbl_password_reset".tr,
      children: [
        CustomTextFormField(
          focusNode: FocusNode(),
          controller: token,
          hintText: "lbl_token".tr,
          textInputType: TextInputType.text,
        ),
        const SizedBox(height: 15),
        CustomTextPasswordField(
            controller: password,
            hintText: "lbl_enter_your_password".tr
        ),
        const SizedBox(height: 15),
        CustomTextPasswordField(
            controller: passwordConfirm,
            hintText: "lbl_confirm_your_password".tr,
            textInputAction: TextInputAction.done
        ),
      ],
      onCancel: onCancel,
      onOk: () {
        if(token.text.isEmpty) {
          CustomDialogAlert(context: context, type: AlertType.warning, message: "lbl_token_empty".tr).show();
        } else if(password.text.isEmpty || passwordConfirm.text.isEmpty) {
          CustomDialogAlert(context: context, type: AlertType.warning, message: "lbl_password_empty".tr).show();
        } else if(Validator.isValidPassword(password.text) == false) {
          CustomDialogAlert(context: context, type: AlertType.warning, message: "lbl_password_invalid".tr).show();
        } else if(password.text != passwordConfirm.text) {
          CustomDialogAlert(context: context, type: AlertType.warning, message: "lbl_passwords_different".tr).show();
        } else {
          onOk();
        }
      }
    ).show();
  }
}
