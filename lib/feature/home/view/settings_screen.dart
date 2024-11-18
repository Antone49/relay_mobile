import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../app_routes.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/utils/color_constant.dart';
import '../../common/view/widgets/custom_button.dart';
import '../../common/view/widgets/custom_state_loading.dart';
import '../viewmodel/bluetooth_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  BluetoothDevice? deviceSelected;

  @override
  void initState() {
    super.initState();
    Provider.of<BluetoothViewModel>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    bool dataReady = context.watch<BluetoothViewModel>().dataReady;

    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: dataReady ? stateWidget(context) : const CustomStateLoading(),
    ));
  }

  Widget stateWidget(BuildContext context) {
    List<BluetoothDevice>? devices =
        Provider.of<BluetoothViewModel>(context, listen: false).bondedDevices;
    deviceSelected ??= Provider.of<BluetoothViewModel>(context, listen: false).device;

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<BluetoothDevice>(
                isExpanded: true,
                items: devices
                    ?.map((BluetoothDevice item) => DropdownMenuItem<BluetoothDevice>(
                          value: item,
                          child: Text(
                            item.platformName,
                            style: AppStyle.fontBlack16,
                          ),
                        ))
                    .toList(),
                value: deviceSelected,
                onChanged: (BluetoothDevice? value) {
                  setState(() {
                    deviceSelected = value!;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
            Expanded(child: Container()),
            CustomButton(
                text: "lbl_save".tr,
                textStyle: AppStyle.fontBlack20,
                onTap: () {
                  Provider.of<BluetoothViewModel>(context, listen: false).saveDevice(deviceSelected!.remoteId.str);
                  Get.offAllNamed(AppRoutes.homeScreen);
                }),
          ],
        ),
      ),
    );
  }
}
