import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/repository/login_repository.dart';
import 'package:splashapp/utiles/utiles.dart';
import 'package:splashapp/view/auth/login/login_view.dart';


class SignUpController extends GetxController {


  final nameController = TextEditingController().obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;

  RxBool loading = false.obs;

  final _api =AuthRepository();


  void signup(){
    loading.value =true;
    var data = {
      "email": emailController.value.text.trim(),
      "name": nameController.value.text.trim(),
      "password": passwordController.value.text.trim(),
      "password_confirmation": confirmpasswordController.value.text.trim(),
    };
    _api.signupApi(data).then((value) {

      if(value['error'] == "email is already register"){
        Utiles.snakBar("Email", "Email is already register");
      }else{
        loading.value=false;
        Utiles.snakBar("Login", "Login Successful");
        Get.to(() => const LoginView());
      }

    }).onError((error, stackTrace) {

      print(error.toString());
      loading.value=false;
      Utiles.snakBar("Error", error.toString());
    });
  }


}
