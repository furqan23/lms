import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../Controller/forget_controller.dart';
import '../../../../values/colors.dart';
import '../../../../values/myimage.dart';
import '../../../../values/text_string.dart';
import '../../../../widget/form_header_widget.dart';

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

                  const  FormHeaderWidget(
                    image: tForgetPasswordImage,
                    title: tForgetPassword,
                    subtitle: tForgetPasswordSubTitle,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    heightBetween: 40.0,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  TextField(
                    controller: _forgetPassword.emailController.value,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(9),
                        hintText: 'Email ID',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        _forgetPassword.forgetApi();
                      },
                      child: _forgetPassword.loading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 4,
                                  fontSize: 20,
                                ),
                              ),
                            ),
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
