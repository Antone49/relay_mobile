import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../common/view/widgets/custom_image_view.dart';
import '../viewmodel/bluetooth_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<BluetoothViewModel>(context, listen: false).scanDevice();
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
      child: Center(
    child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            height: 200,
            svgPath: ImageConstant.imgArrowUp,
            onTap: () {
              ;
            },
          ),
          const SizedBox(height: 100),
          CustomImageView(
            height: 200,
            svgPath: ImageConstant.imgArrowDown,
            onTap: () {
              List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
              for (var d in devs) {
                if (kDebugMode) {
                  print(d);
                }
              }
            },
          ),
        ],
      ),
      ),
    );
  }
}