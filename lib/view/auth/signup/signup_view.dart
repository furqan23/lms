import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/Controller/signup_controller.dart';
import 'package:splashapp/values/constants.dart';
import 'package:splashapp/view/auth/login/login_view.dart';

import '../../../values/colors.dart';
import '../../../values/myimage.dart';
import '../../../values/valdation.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController _signupController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool? _isChecked = false;

  void _toggleCheckBox(bool? value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Size size = MediaQuery.of(context).size;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  child: Image(
                    image: AssetImage(tSplachLogo),
                    width: size.width * 0.57,
                  ),
                ),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20.0,
                    ),
                    topRight: Radius.circular(0.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 0.0,
                  ),
                ],
              ),
              margin: const EdgeInsets.only(
                top: 30,
              ),
              alignment: Alignment.topCenter,

            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        TextFormField(
                          controller: _signupController.nameController.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(9),
                            hintText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value)=>ValidationUtils.validateName(value!),
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        TextFormField(
                          controller: _signupController.emailController.value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(9),
                              hintText: 'Email ID',
                              border: OutlineInputBorder()),
                          validator: (value)=>ValidationUtils.validateEmail(value!),
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        TextFormField(
                          controller: _signupController.passwordController.value,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(9),
                            hintText: 'Password',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value)=>ValidationUtils.validatePassword(value!),
                        ),
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        TextFormField(
                          controller:
                          _signupController.confirmpasswordController.value,
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
                            hintText: 'Confirm Password',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) => ValidationUtils.validatePassword(value!),
                        ),
                        SizedBox(
                          height: size.width * 0.03,
                        ),
                        Obx(() {
                          return InkWell(
                            onTap: () {
                              if (_validateAllFields()) {
                                if (_signupController.passwordController.value.text ==
                                    _signupController.confirmpasswordController.value.text) {
                                  _signupController.signupApi();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Passwords do not match."),
                                    ),
                                  );
                                }
                              }
                            },
                            child: _signupController.loading.value
                                ? Center(child: CircularProgressIndicator())
                                : Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primaryColor,
                                    AppColors.primaryColor,
                                  ], // Adjust the colors as needed
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        }),
                        //////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const LoginView());
                                },
                                child: const Text('Sign In',style: textPrimaryStyle,)),
                          ],
                        ),
                      ]
                  )
                ),
                  ),
            ),

          ),







              ],
            ),
          ),
        ),
      ),
    );
  }


  bool _validateAllFields() {
    return _formKey.currentState!.validate();
  }


}
