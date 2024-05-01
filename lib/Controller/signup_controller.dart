import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../values/auth_api.dart';
import '../view/auth/login/login_view.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController().obs;
  final fNameController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  String? selectedGender;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;

  RxBool loading = false.obs;

  void signupApi() async {
    loading.value = true;
    try {
      var bodyy = {
        "email": emailController.value.text.trim().toString(),
        "name": nameController.value.text.trim().toString(),
        "fname": fNameController.value.text.trim().toString(),
        "contact": phoneNumberController.value.text.trim().toString(),
        "gender": selectedGender,
        "password": passwordController.value.text.trim().toString(),
        "password_confirmation": confirmpasswordController.value.text.trim().toString(),
      };
      print(bodyy);

      final res = await http.post(Uri.parse(AuthApi.registerApi), body: bodyy);

      var data = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        loading.value = false;
        if(data['success']==true){
        Get.snackbar('SignUp Successful',"User Created Successfully", );
        }else{
          Get.snackbar('SignUp Successful',"${res.statusCode} \n ${res.body}", );
        }

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
