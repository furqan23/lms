import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/view/auth/login/login_view.dart';

import '../../values/auth_api.dart';

class ResetpasswordController extends GetxController {
  final TextEditingController otpsController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confrimpasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  RxBool loading = false.obs;

  void ResetPasswordApi(String otp, String email) async {
    loading.value = true;
    Get.snackbar(otp, email);

    try {
      final res = await http.post(Uri.parse(AuthApi.resetspasswordApi), body: {
        "code": otp,
        "password": passwordController.text,
        "password_confirmation": confrimpasswordController.text,
        "email": email.toString().trim(),
      });
      var data = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        if (data['success'] == true) {
          loading.value = false;

          // Show a success dialog
          Get.defaultDialog(
            title: 'Password Changed',
            middleText: 'Your password has been changed successfully.',
            textConfirm: 'OK',
            onConfirm: () {
              Get.to(() => const LoginView()); // Navigate to the home page
            },
          );
        } else {
          loading.value = false;
          Get.snackbar('Login Failed', data['error']);
        }
      } else if (res.statusCode == 400) {
        loading.value = false;
        Get.snackbar('Login Failed', data['error']);
      } else {
        loading.value = false;
        Get.snackbar('Login Failed', 'Please create an Account and try again.');
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Get.snackbar('Exception', e.toString());
    }
  }
}
