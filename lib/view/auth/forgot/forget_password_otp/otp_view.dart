import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:splashapp/values/colors.dart';
import '../../../../Controller/opt_controller.dart';
import 'package:get/get.dart';

import '../../../../values/text_string.dart';

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
            padding: EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/forget-password.png'),width: 150,  ),
                SizedBox(height: 10),
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
                          border: Border.all(color: AppColors.primaryColor)
                      ),
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
                  return InkWell(
                    onTap: () {
                      _otpController.otpApi(widget._email);
                    },
                    child: _otpController.loading.value
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),  color: AppColors.primaryColor,
                      ),
                            child: const Text(
                              'Verify', // Corrected the text here
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
    );
  }
}
