import 'dart:convert';
// import 'package:device_information/device_information.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:splashapp/view/auth/login/login_view.dart';
import 'package:splashapp/view/home/home_screen.dart';
import '../values/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool loading = false.obs;
  String? tokenString;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    // initPlatformState();
  }

  void checkLoginStatus() async {
    final box = await Hive.openBox<String>('tokenBox');
    final String? token = box.get('token');

    if (token != null) {
      Get.off(() => const HomeScreen(), transition: Transition.noTransition);
    }
  }

  void loginApi() async {
    loading.value = true;

    try {
      final email = emailController.value.text.toString().trim();
      final password = passwordController.value.text.toString().trim();
      final imei = imeiNo.value;

      print('Email: $email');
      print('Password: $password');
      print('IMEI: $imei');
      final res = await http.post(Uri.parse(AuthApi.loginApi), body: {
        'email': email,
        'password': password,
       //'device_imei': imei,

      });

      var data = jsonDecode(res.body);
      print("login res ${res.body}  ${res.statusCode}");
      if (res.statusCode == 200) {
        if (data['success'] == true) {
          // Extract the token from the response
          String token = data['message']['token'];
          String userName = data['message']['name'];

          // Store the token in the Hive box
          final box = await Hive.openBox<String>('tokenBox');
          await box.put('token', token);
          await box.put('email', emailController.value.text.toString().trim());
          await box.put('username', userName);
          // Print the saved token
          // print('Token saved: $token');
          print('Token saved: $userName     ');
          loading.value = false;
          Get.snackbar('Login Successful', 'Congratulations');

          Get.offAll(() => const HomeScreen());
        } else {
          loading.value = false;
          Get.snackbar('Login Failed', data['message']['name']);
        }
      } else if (res.statusCode == 400) {
        loading.value = false;
        Get.snackbar('Login Failed', data['message']['name']);
      } else {
        loading.value = false;
        Get.snackbar('Login Failed', 'Please create an account and try again.');
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Get.snackbar('Exception', e.toString());
    }
  }

  void logout() async {
    // Clear the email and password fields
    emailController.value.clear();
    passwordController.value.clear();

    ////////////token///////////////////
    final box = await Hive.openBox<String>('tokenBox');
    await box.delete('token');
    Get.offAll(() => LoginView(), transition: Transition.fade);
  }

  //// get Hive token from hive
  Future<String?> getTokenFromHive() async {
    final box = await Hive.openBox<String>('tokenBox');
    return box.get('token');
  }


  var platformVersion = 'Unknown'.obs;
  var imeiNo = ''.obs;
  // var modelName = ''.obs;
  // var manufacturerName = ''.obs;
  // var apiLevel = ''.obs;
  // var deviceName = ''.obs;
  // var productName = ''.obs;
  // var cpuType = ''.obs;
  // var hardware = ''.obs;



  // Future<void> initPlatformState() async {
  //   try {
  //     platformVersion.value = await DeviceInformation.platformVersion;
  //     imeiNo.value = await DeviceInformation.deviceIMEINumber;
  //     // modelName.value = await DeviceInformation.deviceModel;
  //     // manufacturerName.value = await DeviceInformation.deviceManufacturer;
  //     // apiLevel.value = await DeviceInformation.apiLevel;
  //     // deviceName.value = await DeviceInformation.deviceName;
  //     // productName.value = await DeviceInformation.productName;
  //     // cpuType.value = await DeviceInformation.cpuName;
  //     // hardware.value = await DeviceInformation.hardware;
  //   } on PlatformException catch (e) {
  //     platformVersion.value = '${e.message}';
  //   }
  // }
}
