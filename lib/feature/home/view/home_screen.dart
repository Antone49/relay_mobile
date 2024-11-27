import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../app_routes.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../common/view/widgets/custom_button_repeat.dart';
import '../viewmodel/bluetooth_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ValueNotifier<bool> isConnected = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    Provider.of<BluetoothViewModel>(context, listen: false).connectDefaultDevice();
    isConnected = Provider.of<BluetoothViewModel>(context, listen: false).isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.backgroundColor,
          body: stateWidget(context),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorConstant.primary,
            child: const Icon(Icons.settings),
            onPressed: () {
              Get.toNamed(AppRoutes.settingsScreen);
            },
          ),
        )
    );
  }

  Widget stateWidget(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(80),
        child: ValueListenableBuilder<bool>(
            valueListenable: isConnected,
            builder: (context, value, child) {
              return Column(
                children: [
                  Text(
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: isConnected.value ? AppStyle.fontGreen20 : AppStyle.fontRed20,
                      isConnected.value
                          ? "lbl_bluetooth_connected".tr
                          : "lbl_bluetooth_disconnected".tr),
                  const SizedBox(height: 50),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomButtonRepeat(
                          height: 200,
                          isConnected: isConnected.value,
                          svgImage: ImageConstant.imgArrowUp,
                          svgImageTouched: ImageConstant.imgArrowUpTouched,
                          svgImageUnconnected: ImageConstant.imgArrowUpGray,
                          onTap: () {
                            Provider.of<BluetoothViewModel>(context, listen: false).write("Up");
                          },
                          onTapStop: () {
                            Provider.of<BluetoothViewModel>(context, listen: false).write("UpStop");
                          },
                        ),
                        const SizedBox(height: 80),
                        CustomButtonRepeat(
                          height: 200,
                          isConnected: isConnected.value,
                          svgImage: ImageConstant.imgArrowDown,
                          svgImageTouched: ImageConstant.imgArrowDownTouched,
                          svgImageUnconnected: ImageConstant.imgArrowDownGray,
                          onTap: () {
                            Provider.of<BluetoothViewModel>(context, listen: false).write("Down");
                          },
                          onTapStop: () {
                            Provider.of<BluetoothViewModel>(context, listen: false).write("DownStop");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
        )
    );
  }
}
