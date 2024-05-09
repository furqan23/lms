import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/components/customfield_components.dart';
import 'package:splashapp/res/components/mybutton_widget.dart';
import 'package:splashapp/test_screen.dart';
import 'package:splashapp/res/constants/constants.dart';
import 'package:splashapp/view/auth/login/login_view.dart';
import 'package:splashapp/view_model/Controller/auth/signup_controller.dart';
import '../../../res/assetsimages/myimage.dart';
import '../../../res/valdations/valdation.dart';

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
          body: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    child: Image(
                      image: AssetImage(tSplachLogo),
                    ),
                  ),
                ),
                Container(
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
                            height: size.height * 0.01,
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

                          CustomFieldComponets(
                            obscureText: false,
                            controller: _signupController.nameController.value,
                            hintText: 'First Name',
                            validator: (value) =>
                                ValidationUtils.validateName(value!),
                          ),

                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          CustomFieldComponets(
                            obscureText: false,
                            controller: _signupController.emailController.value,
                            hintText: 'Email ID',
                            validator: (value) =>
                                ValidationUtils.validateEmail(value!),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),

                          CustomFieldComponets(
                            controller:
                                _signupController.passwordController.value,
                            hintText: 'Password',
                            obscureText: _obscureText, // Password is obscured
                            suffixIcon: _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onpressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            validator: (value) =>
                                ValidationUtils.validatePassword(value!),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          CustomFieldComponets(
                            controller: _signupController
                                .confirmpasswordController.value,
                            hintText: 'Confirm Password',
                            obscureText: _obscureText, // Password is obscured
                            suffixIcon: _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onpressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            validator: (value) =>
                                ValidationUtils.validatePassword(value!),
                          ),

                          SizedBox(
                            height: size.width * 0.03,
                          ),
                          Obx(() {
                            return MyButtonWidget(
                                btntitle: "Sign Up",
                                isLoading: _signupController.loading.value,
                                onpressed: () {
                                  if (_validateAllFields()) {
                                    _signupController.signup();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Passwords do not match."),
                                      ),
                                    );
                                  }
                                });
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
                                  child: const Text(
                                    'Sign In',
                                    style: textPrimaryStyle,
                                  )),
                            ],
                          ),

                          TextButton(
                              onPressed: () {
                                Get.to(() => const TestScreen());
                              },
                              child: const Text(
                                '.',
                                style: textPrimaryStyle,
                              )),
                        ])),
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
