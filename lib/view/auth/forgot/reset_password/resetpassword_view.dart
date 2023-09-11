import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import 'package:splashapp/Controller/forget_controller.dart';
import 'package:splashapp/view/auth/forgot/forget_password_email/forgetpassword_view.dart';
import '../../../../Controller/resetpassword_controller.dart';
import '../../../../values/colors.dart';
class ResetPasswordView extends StatefulWidget {
String otp,email;
 ResetPasswordView( {super.key,required this.email,required this.otp});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  // final emailController = TextEditingController();
  ResetpasswordController _resetpasswordController = Get.put(ResetpasswordController());
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
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/forget-password.png'),width: 150,  ),
                    const SizedBox(height: 20),
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),


                    TextField(
                      controller: _resetpasswordController.passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(9),
                          labelText: 'New password',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextField(
                      controller:
                      _resetpasswordController.confrimpasswordController,
                      obscureText: _obscureText1,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText1 = !_obscureText1;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.all(9),
                        labelText: 'New password',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          _resetpasswordController.ResetPasswordApi(widget.otp,widget.email);
                        },
                        child: _resetpasswordController.loading.value
                            ? Center(child: CircularProgressIndicator())
                            : Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                           color: AppColors.primaryColor,
                          ),
                          child: const Text(
                            'Reset Password', // Corrected the text here
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
