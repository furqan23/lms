import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/components/form_header_widget.dart';
import 'package:splashapp/res/components/mybutton_widget.dart';
import 'package:splashapp/res/assetsimages/myimage.dart';
import 'package:splashapp/res/stringstext/text_string.dart';
import 'package:splashapp/view_model/Controller/auth/forget_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ForgotController _forgetPassword = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const FormHeaderWidget(
                    image: tForgetPasswordImage,
                    title: tForgetPassword,
                    subtitle: tForgetPasswordSubTitle,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    heightBetween: 40.0,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _forgetPassword.emailController.value,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(9),
                        hintText: 'Email ID',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return MyButtonWidget(
                      btntitle: "Reset",
                      isLoading: _forgetPassword.loading.value,
                      onpressed: () {
                        _forgetPassword.fogetsapi();
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
