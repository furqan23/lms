// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashapp/model/get_test_model.dart';
import 'package:splashapp/demo.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/values/constants.dart';
import 'package:splashapp/view/quizz/get_testquestion_view.dart';
import 'package:splashapp/widget/testcard_widget.dart';

import '../../Controller/login_controller.dart';
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
    print('Token: $token');
    getMyCourseAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Tests"),
      ),
      body: boolData
          ? ListView.builder(
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

                    getTestDetailAPI(getTestList[0].data![index].id.toString());
                  },
                  child: TestCard(
                    id: getTestList[0].data![index].courseId.toString(),
                    title: getTestList[0].data![index].testTitle.toString(),
                    start: getTestList[0].data![index].testStart.toString(),
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
          print('Parsed Data: $mydata');
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
          return Center(child: CircularProgressIndicator());
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

      print('Response Status Code: ${res.statusCode} widget id ${widget.id}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          // getTestList.add(GetTestModel.fromJson(mydata));

          int total_time = int.parse(mydata['data']['total_time']);
          int total_question = mydata['data']['total_question'];
          String test_title = mydata['data']['test_title'];

          Get.dialog(
              barrierDismissible: false,
              Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Text Name: $test_title",
                          style: textBoldStyle,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // Image.asset(AppImage.internetConnection,height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Questions: ",
                          ),
                          Text(
                            "$total_question",
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.greyshade100,
                        thickness: 1,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Time:",
                          ),
                          Text(
                            "$total_time min",
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.greyshade100,
                        thickness: 1,
                      ),

                      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Total Time:   $total_time",),
                      //     Text("   $total_time",),
                      //   ],
                      // ),
                      // Divider(
                      //   color: AppColors.greyshade100,
                      //   thickness: 1,
                      // ),

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
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Text(
                                  "Not Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {

                              if (canStartQuiz) {

                               getTestinfoAPI(id.toString());
                              } else {
                                Get.to(() => QuizzView(id: id.toString(), totalTime: total_time, totalQuestions: total_question));
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
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

  void getTestinfoAPI(String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
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
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');


          setState(() {
            boolData = true;
          });
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
