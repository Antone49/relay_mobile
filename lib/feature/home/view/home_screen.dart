import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_style.dart';
import '../../../core/utils/color_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.backgroundColor,
          body: stateWidget(context),
        )
    );
  }

  Widget stateWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
              "lbl_error".tr,
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