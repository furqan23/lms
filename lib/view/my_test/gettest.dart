// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashapp/model/get_test_model.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/res/assets/images_assets.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/constants/constants.dart';
import 'package:splashapp/res/stringstext/text_string.dart';
import 'package:splashapp/view/quizz/quizz_view.dart';
import 'package:splashapp/widget/incoming_job_dialog.dart';
import 'package:splashapp/widget/testcard_widget.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import '../../values/auth_api.dart';

class GetTest extends StatefulWidget {
  String id;

  GetTest({super.key, required this.id});

  @override
  State<GetTest> createState() => _GetTestState();
}

class _GetTestState extends State<GetTest> {
  bool canStartQuiz = true;
  String? token;
  List<GetTestModel> getTestList = [];
  List<MyCoursesModel> myCoursesList = [];
  bool boolData = false;

  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Tokens: $token');
    getMyCourseAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Tests"),
      ),
      body: boolData
          ? getTestList[0].data?.length == 0
              ? const Center(
                  child: Text("Sorry No Test available Yet"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: getTestList[0].data?.length,
                  itemBuilder: (context, index) {
                    final test = getTestList[0].data![index];
                    final testStart = test.testStart ?? "";
                    final testStartDateTime = DateTime.tryParse(testStart);
                    final currentDateTime = DateTime.now();
                    return InkWell(
                      onTap: () {
                        //  Get.to(()=>DemoApp());
                        //  Get.to(()=>QuizzView(id: getTestList[0].data![index].id.toString()));

                        getTestDetailAPI(
                            getTestList[0].data![index].id.toString());
                      },
                      child: TestCard(
                        id: getTestList[0].data![index].courseId.toString(),
                        test_code:
                            getTestList[0].data![index].test_code.toString(),
                        title: getTestList[0].data![index].testTitle.toString(),
                        start: getTestList[0].data![index].testStart.toString(),
                        total: getTestList[0].data![index].totalTime.toString(),
                      ),
                    );
                  })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void getMyCourseAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "course_id": widget.id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.getTestApi),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
            'Content-Type': 'application/json',
          },
          body: requestBody);

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);

          print('gettest: $mydata');
          getTestList.add(GetTestModel.fromJson(mydata));

          setState(() {
            boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getTestDetailAPI(String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      final Map<String, dynamic> requestData = {
        "test_id": id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.startTestApi),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
            'Content-Type': 'application/json',
          },
          body: requestBody);

      print(
          'Response Status Codeeee: ${res.statusCode} widget id ${widget.id}');
      print('Response Body: ${res.body}');
      // final mydata;
      final mydata = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Get.back();
        print('gettest api: $mydata');
        // getTestList.add(GetTestModel.fromJson(mydata));
        if (mydata["success"] == true) {
          int total_time = int.parse(mydata['data']['total_time']);
          int total_question = mydata['data']['total_question'];
          String test_title = mydata['data']['test_title'];
          String test_amount = mydata['data']['fee'].toString();
          String test_date = mydata['data']['test_start'].toString();

          Get.dialog(
              barrierDismissible: false,
              Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "${test_title.toUpperCase()}",
                          style: textBoldStyleDialog,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Image.asset(AppImage.internetConnection,height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Start Date: ",
                          ),
                          Text(
                            "$test_date",
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.greyshade100,
                        thickness: 1,
                      ),
                      // Image.asset(AppImage.internetConnection,height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Questions: ",
                          ),
                          Text(
                            "$total_question",
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.greyshade100,
                        thickness: 1,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Time:",
                          ),
                          Text(
                            "$total_time Min",
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.greyshade100,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount:",
                          ),
                          Text(
                            "$currency $test_amount",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (canStartQuiz) {
                                print("here test info api button click");
                                getTestinfoAPI(id.toString());
                              } else {
                                Get.back();
                                Get.off(() => QuizzView(
                                    id: id.toString(),
                                    totalTime: total_time,
                                    totalQuestions: total_question));
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Text(
                                  "Start",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));

          setState(() {
            boolData = true;
          });
        } else {
          print("here low balance");
          Get.back();
          Get.dialog(
              IncomingJob(
                icon: MyImgs.dialogIcon,
                text: mydata["message"],
              ),
              barrierDismissible: false);
        }
      } else if (res.statusCode == 422) {
        print("here low balance");
        Get.back();
        Get.dialog(
            IncomingJob(
              icon: MyImgs.dialogIcon,
              text: mydata["message"],
            ),
            barrierDismissible: false);
      } else {
        print('Error: ${res.statusCode}');
        Get.back();
      }
    } catch (e) {
      print(e.toString());
      Get.back();
    }
  }

  void getTestinfoAPI(String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      final Map<String, dynamic> requestData = {
        "test_id": id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.testinfo),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
            'Content-Type': 'application/json',
          },
          body: requestBody);

      print('Response Status Code: ${res.statusCode} widget id ${widget.id}');
      print('Response Body test info: ${res.body}');

      if (res.statusCode == 200) {
        Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('test info api Data: $mydata');
          // if (mydata["success"] == true) {
          int total_time = int.parse(mydata['data']['total_time']);
          int total_question = mydata['data']['total_question'];
          String test_title = mydata['data']['test_title'];
          Get.off(() => QuizzView(
              id: id.toString(),
              totalTime: total_time,
              totalQuestions: total_question));

          setState(() {
            boolData = true;
          });
          // } else {
          //   // Get.dialog(IncomingJob(text: mydata["message"],icon: MyImgs.dialogIcon,));
          //   print("here low balance");
          //   Get.back();
          //   Get.dialog(
          //       IncomingJob(
          //         icon: MyImgs.dialogIcon,
          //         text: mydata["message"],
          //       ),
          //       barrierDismissible: false);
          // }
        } else {
          throw Exception('Empty response');
        }
      } else {
        print('Error: ${res.statusCode}');
        Get.back();
      }
    } catch (e) {
      print(e.toString());
      Get.back();
    }
  }
}
