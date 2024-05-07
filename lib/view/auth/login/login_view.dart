// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/constants/constants.dart';
import 'package:splashapp/res/valdations/valdation.dart';
import 'package:splashapp/view/auth/signup/signup_view.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import '../../../res/assetsimages/myimage.dart';
import '../forgot/forget_password_email/forgetpassword_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    // _requestPermissions();
  }

  // Future<void> _requestPermissions() async {
  //   final PermissionStatus cameraPermissionStatus =
  //   await Permission.camera.status;
  //   final PermissionStatus storagePermissionStatus =
  //   await Permission.storage.status;
  //   final PermissionStatus phonePermissionStatus = await Permission.phone.status;
  //
  //   if (!cameraPermissionStatus.isGranted) {
  //     await Permission.camera.request();
  //   }
  //
  //   if (!storagePermissionStatus.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   if (!phonePermissionStatus.isGranted) {
  //     await Permission.phone.request();
  //   }
  // }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginController _loginController = Get.put(LoginController());
  bool _obscureText = true;

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
                    top: 10,
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
                            "Login",
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller:
                                  _loginController.emailController.value,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(9),
                                  hintText: 'Email ID',
                                  border: OutlineInputBorder()),
                              validator: (value) =>
                                  ValidationUtils.validateEmail(value!.trim()),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller:
                                  _loginController.passwordController.value,
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
                                  hintText: 'Password',
                                  border: OutlineInputBorder()),
                              validator: (value) =>
                                  ValidationUtils.validatePassword(value!),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(
                                  () => const ForgetPassword(),
                                );
                              },
                              child: const Text(
                                'Forgot Password',
                                style: textPrimaryStyle,
                              ),
                            ),
                          ),
                          Obx(() {
                            return InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _loginController.loginApi();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please enter your email and password.'),
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: _loginController.loading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.whiteColor,
                                            ),
                                          )
                                        : const Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                  ),
                                ));
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const SignUpView());
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: textPrimaryStyle,
                                  ))
                            ],
                          )
                        ],
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
