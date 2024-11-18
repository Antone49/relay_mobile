import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../service/storage/storage_service.dart';

class BluetoothViewModel with ChangeNotifier {
  bool dataReady = false;
  ValueNotifier<bool> isConnected = ValueNotifier<bool>(false);
  List<BluetoothDevice>? bondedDevices;
  BluetoothDevice? device;
  BluetoothCharacteristic? lastCharacteristic;

  BluetoothViewModel() {
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }
  }

  Future<void> connectDefaultDevice() async {
    String? address = await StorageService().read("ADDRESS");
    if(address != null && device?.remoteId.str != address) {
      connectDevice(address);
    }
  }

  Future<void> saveDevice(String address) async {
      StorageService().write("ADDRESS", address);
  }

  Future<void> connectDevice(String address) async {
    if(device!= null && device!.isConnected) {
      device!.disconnect();
    }

    device = BluetoothDevice.fromId(address);
    await device?.connect(autoConnect : true, mtu:null);

    FlutterBluePlus.events.onConnectionStateChanged.listen((event) async {
      print('${event.device} ${event.connectionState}');

      if(event.connectionState == BluetoothConnectionState.connected && device!.isConnected) {
        List<BluetoothService> services = await device!.discoverServices();
        lastCharacteristic = services.last.characteristics.last;
        lastCharacteristic?.setNotifyValue(true);
        isConnected.value = true;
      } else {
        isConnected.value = false;
      }
    }
    );
  }

  void fetchBondedDevices() async {
    bondedDevices?.clear();
    bondedDevices = await FlutterBluePlus.bondedDevices;

    checkDataReady();
  }

  void fetchData() {
    dataReady = false;

    fetchBondedDevices();
  }

  void clearData() {
    bondedDevices = null;
  }

  void checkDataReady() {
    dataReady = bondedDevices != null;

    if(dataReady) {
      notifyListeners();
    }
  }

  Future<void> write(String text) async {
    if (device != null && device!.isConnected) {
      await lastCharacteristic?.write(utf8.encode(text));
    } else {
      print('Bluetooth no connection');
    }
  }
}