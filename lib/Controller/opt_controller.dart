import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../values/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../view/auth/forgot/reset_password/resetpassword_view.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();


  RxBool loading = false.obs;

  void otpApi(String _email) async {
    loading.value = true;
    try {
      final res = await http.post(Uri.parse(AuthApi.otpApi), body: {
        'code': otpController.text,

      });

      var data = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        loading.value = false;
        Get.snackbar('Verification Success', 'Success');
        Get.to(() =>  ResetPasswordView(
         otp: otpController.text,email: _email
        ));
      } else {
        loading.value = false;
        Get.snackbar('Verification Failed', data['error']);
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Get.snackbar('Exception', e.toString());
    }
  }
}
