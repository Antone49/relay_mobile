import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_style.dart';
import '../../../../core/utils/image_constant.dart';
import '../../../../core/utils/size_utils.dart';
import 'custom_image_view.dart';

class CustomStateError extends StatelessWidget {
  const CustomStateError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            svgPath: ImageConstant.imgErrorNotFound,
            height: getVerticalSize(100),
            width: getHorizontalSize(100),
          ),
          const SizedBox(height: 20),
          Text(
            "lbl_error_not_found".tr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppStyle.fontBlack16,
            maxLines: 5
          ),
        ],
      ),
    );
  }
}