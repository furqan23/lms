import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/repository/login_repository.dart';
import 'package:splashapp/utiles/utiles.dart';
import '../../../view/auth/forgot/reset_password/resetpassword_view.dart';
import 'package:http/http.dart' as http;
class OtpController extends GetxController {
  final _api = AuthRepository();
  final TextEditingController otpController = TextEditingController();

  RxBool loading = false.obs;

  void otp(String _email) {
    loading.value = true;
    var data = {
      'code': otpController.text,
    };
    _api.otpApi(data).then((value) {
      loading.value = false;
      Utiles.snakBar('Verification Success', 'Success');
      Get.to(() => ResetPasswordView(otp: otpController.text, email: _email));
    }).onError((error, stackTrace) {
      print(error.toString());
      loading.value = false;
      Utiles.snakBar("Error", error.toString());
    });
  }
}
