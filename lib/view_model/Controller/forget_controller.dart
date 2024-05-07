import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/repository/login_repository.dart';
import 'package:splashapp/utiles/utiles.dart';
import 'package:splashapp/view/auth/forgot/forget_password_otp/otp_view.dart';

class ForgotController extends GetxController {
  final _api = AuthRepository();

  final emailController = TextEditingController().obs;

  RxBool loading = false.obs;

  void fogetsapi() {
    loading.value = true;
    var data = {
      'email': emailController.value.text.toString().trim(),
    };
    _api.forgetApi(data).then((value) {
      loading.value = false;
      Utiles.snakBar('Message', 'We have emailed your password reset code');
      Get.to(() => OtpView(emailController.value.text.toString().trim()));
    }).onError((error, stackTrace) {
      print(error.toString());
      loading.value = false;
      Utiles.snakBar("Error", error.toString());
    });
  }
}
