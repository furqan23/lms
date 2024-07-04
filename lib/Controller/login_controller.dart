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

import '../values/logs.dart';

class LoginController extends GetxController {
  String? token;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool loading = false.obs;
  String? tokenString;
  var platformVersion = 'Unknown'.obs;
  var imeiNo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    // initPlatformState();
  }


  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');

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




  void deleteAPI() async {
    loading.value = true;

    try {
      await getTokenAndFetchInvoice();
      final res = await http.post(
        Uri.parse(AuthApi.deleteApi),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['success'] == true) {
          loading.value = false;
          Get.snackbar('Account Deleted', 'Account deleted successfully.');
          logout(); // Log out the user after deleting the account
        } else {
          loading.value = false;
          Get.snackbar('Delete Failed', data['message']);
        }
      } else if (res.statusCode == 400) {
        loading.value = false;
        final data = jsonDecode(res.body);
        Get.snackbar('Delete Failed', data['message']);
      } else {
        loading.value = false;
        Get.snackbar('Delete Failed', 'Unable to delete the account. Please try again.');
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Get.snackbar('Exception', e.toString());
    }
  }

}