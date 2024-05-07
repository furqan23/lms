import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:splashapp/res/components/mybutton_widget.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/stringstext/text_string.dart';
import 'package:splashapp/view_model/Controller/opt_controller.dart';

class OtpView extends StatefulWidget {
  String _email;
  OtpView(String this._email, {Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  OtpController _otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/forget-password.png'),
                    width: 150,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    tOtpSubTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 19),
                  const Text(
                    tOtpMessage,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Pinput(
                    controller: _otpController.otpController,
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    defaultPinTheme: PinTheme(
                        height: 65,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor)),
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        )),
                    onChanged: (value) {
                      // Handle PIN input changes if needed
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Obx(() {
                    return MyButtonWidget(
                        btntitle: "Verify",
                        onpressed: () {
                          _otpController.otp(widget._email);
                        },
                        isLoading: _otpController.loading.value);
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
