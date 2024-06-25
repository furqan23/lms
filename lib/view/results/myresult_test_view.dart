import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/results/myfinal_result_view.dart';
import '../../Controller/login_controller.dart';
import '../../model/mytest_results_model.dart';

class MyResultsTest extends StatefulWidget {
  String id;
  MyResultsTest({super.key, required this.id});

  @override
  State<MyResultsTest> createState() => _MyResultsTestState();
}

class _MyResultsTestState extends State<MyResultsTest> {
  /* ------------- declare  variable token and Model ------------*/
  String? token;
  List<TestResultModels> getresultList = [];
  bool boolData = false;

  /*---------- InitState Call -----------------*/
  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  /*------------------ Fetch Token ----------------*/
  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    getMyTestResultAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Test Results"),
      ),
      body: boolData
          ? ListView.builder(
              itemCount: getresultList[0].data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text("CourseTitle : "),
                            Text(getresultList[0]
                                .data![index]
                                .courseTitle
                                .toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text("TestTile : "),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .74,
                                child: Text(
                                  getresultList[0]
                                      .data![index]
                                      .testTitle
                                      .toString(),
                                  style:
                                  TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                )),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text("Test Date : "),
                            Text(getresultList[0]
                                .data![index]
                                .testStart
                                .toString()),
                          ],
                        ),
                      ),



                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => MyFinalResult(
                              id: getresultList[0].data![index].id!));
                        },
                        child: const Text("View Results"),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  /*------------------ Call GetTestQuestionApi  ----------------*/
  void getMyTestResultAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "course_id": widget.id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.getMyResultsTestApi),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
            'Content-Type': 'application/json',
          },
          body: requestBody);

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          getresultList.add(TestResultModels.fromJson(mydata));

          setState(() {
            boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
