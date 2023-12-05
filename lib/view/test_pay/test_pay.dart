import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:device_information/device_information.dart';
import 'package:get/get.dart';
import 'package:splashapp/Controller/login_controller.dart';
class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final deviceInfoController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Information Plugin Example app'),
        ),
        body: Center(
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text('${deviceInfoController.platformVersion}\n'),
              const SizedBox(
                height: 10,
              ),
              Text('IMEI Number: ${deviceInfoController.imeiNo}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('Device Model: ${deviceInfoController.modelName}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('API Level: ${deviceInfoController.apiLevel}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('Manufacture Name: ${deviceInfoController.manufacturerName}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('Device Name: ${deviceInfoController.deviceName}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('Product Name: ${deviceInfoController.productName}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('CPU Type: ${deviceInfoController.cpuType}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('Hardware Name: ${deviceInfoController.hardware}\n'),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          )),
        ),
      ),
    );
  }
}