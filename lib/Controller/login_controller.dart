import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:splashapp/view/auth/login/login_view.dart';
import 'package:splashapp/view/home/home_screen.dart';
import '../values/auth_api.dart';
import 'package:flutter/material.dart';

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
    requestPermissionsAndFetchIMEI();
  }

  Future<void> requestPermissionsAndFetchIMEI() async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }
    if (status.isGranted) {
      await initPlatformState();
    } else {
      Get.snackbar('Permission Denied', 'Phone state permission is required to fetch the IMEI number.');
    }
  }

  Future<void> initPlatformState() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (GetPlatform.isAndroid) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        imeiNo.value = androidInfo.serialNumber!;
        print("this phone imei${imeiNo.value}");
      } else {
        Get.snackbar('Unsupported Platform', 'This functionality is only available on Android devices.');
      }
    } catch (e) {
      print('Failed to get platform version: $e');
    }
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await getTokenFromHive();
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
// okay test
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
        'device_imei': imei,
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
          print('Token saved: $userName');
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
    emailController.value.clear();
    passwordController.value.clear();

    final box = await Hive.openBox<String>('tokenBox');
    await box.delete('token');
    Get.offAll(() => LoginView(), transition: Transition.fade);
  }

  Future<String?> getTokenFromHive() async {
    final box = await Hive.openBox<String>('tokenBox');
    return box.get('token');
  }

  void deleteAPI() async {
    loading.value = true;

    try {
      await getTokenAndFetchInvoice();
      final res = await http.post(
        Uri.parse(AuthApi.deleteApi),
        headers: {
          'Authorization': 'Bearer $token',
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
          logout();
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
