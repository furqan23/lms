import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../values/auth_api.dart';
import '../view/auth/login/login_view.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController().obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;

  RxBool loading = false.obs;

  void signupApi() async {
    loading.value = true;
    try {
      var bodyy = {
        "email": emailController.value.text.trim(),
        "name": nameController.value.text.trim(),
        "password": passwordController.value.text.trim(),
        "password_confirmation": confirmpasswordController.value.text.trim(),
      };
      print(bodyy);

      final res = await http.post(Uri.parse(AuthApi.registerApi), body: bodyy);

      var data = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        loading.value = false;
        Get.snackbar('SignUp Successful', 'Congratulations');
        Get.to(()=> LoginView());
      } else if (res.statusCode == 400) {
        loading.value = false;
        Get.snackbar('SignUp Failed', data['error']);
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
