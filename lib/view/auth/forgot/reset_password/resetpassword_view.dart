import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/components/customfield_components.dart';
import 'package:splashapp/res/components/mybutton_widget.dart';
import 'package:splashapp/view_model/Controller/forget_controller.dart';
import 'package:splashapp/view_model/Controller/resetpassword_controller.dart';

class ResetPasswordView extends StatefulWidget {
  String otp, email;
  ResetPasswordView({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ResetpasswordController _resetpasswordController =
      Get.put(ResetpasswordController());
  ForgotController _forggetController = Get.put(ForgotController());
  bool _obscureText = true;
  bool _obscureText1 = true;
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image:
                                AssetImage('assets/images/forget-password.png'),
                            width: 150,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomFieldComponets(
                            controller:
                                _resetpasswordController.passwordController,
                            hintText: 'New password',
                            obscureText: _obscureText, // Password is obscured
                            suffixIcon: _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onpressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          CustomFieldComponets(
                            controller: _resetpasswordController
                                .confrimpasswordController,
                            hintText: 'New password',
                            obscureText: _obscureText1, // Password is obscured
                            suffixIcon: _obscureText1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onpressed: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Obx(() {
                            return MyButtonWidget(
                              btntitle: "Verify",
                              onpressed: () {
                                _resetpasswordController.ResetPasswordApi(
                                    widget.otp, widget.email);
                              },
                              isLoading: _resetpasswordController.loading.value,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
