import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/view/auth/forgot/forget_password_email/forgetpassword_view.dart';
import 'package:splashapp/view/auth/forgot/forget_password_otp/otp_view.dart';
import '../values/auth_api.dart';

class ForgotController extends GetxController{

  final emailController =TextEditingController().obs;


  RxBool loading =false.obs;
  void forgetApi() async {
    loading.value = true;
    try {
      final res = await http.post(Uri.parse(AuthApi.resetpasswordApi), body: {
        'email': emailController.value.text.toString().trim(),
      });
      var data = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        loading.value = false;
        Get.snackbar('Message', 'We have emailed your password reset code');
        Get.to(() =>  OtpView(emailController.value.text.toString().trim()));
      } else if (res.statusCode == 400) {
        loading.value = false;
        Get.snackbar('Password Reset Failed', data['error']);
      } else {
        loading.value = false;
        Get.snackbar('Unexpected Error', 'An unexpected error occurred.');
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Get.snackbar('Exception', e.toString());
    }
  }
}