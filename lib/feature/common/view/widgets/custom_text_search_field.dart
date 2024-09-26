import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_decoration.dart';
import '../../../../core/utils/color_constant.dart';


class CustomTextSearchField extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  final ValueChanged<String> onSubmit;

  CustomTextSearchField({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: textController,
            textAlignVertical: TextAlignVertical.center,
            onSubmitted: (val) async {
              onSubmit(val);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              hintText: "lbl_search".tr,
              isCollapsed: true,
              border: OutlineInputBorder(borderRadius: BorderRadiusStyle.circularBorder20),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: ColorConstant.primary, size: 16,),
                onPressed: () {
                  onSubmit(textController.text);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}