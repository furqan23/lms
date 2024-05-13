import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/res/components/myresulttest_Card.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/results/myfinal_result_view.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import 'package:splashapp/view_model/Controller/myresults/testresults_controller.dart';
import '../../model/mytest_results_model.dart';

class MyResultsTest extends StatefulWidget {
  String id;
  MyResultsTest({super.key, required this.id});

  @override
  State<MyResultsTest> createState() => _MyResultsTestState();
}

class _MyResultsTestState extends State<MyResultsTest> {
  final TestResultsController testResultsController =
      Get.put(TestResultsController());
  /* ------------- declare  variable token and Model ------------*/
  late String token;
  bool boolData = false;

  /*---------- InitState Call -----------------*/
  @override
  void initState() {
    super.initState();
    getTokenAndFetchVideos();
  }

  Future<void> getTokenAndFetchVideos() async {
    token = (await LoginController().getTokenFromHive())!;
    print('Token: $token');
    testResultsController.getresultsApi(widget.id, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Test Results"),
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: testResultsController.getmyresult.value!.length,
            itemBuilder: (context, index) {
              final gettestresult =
                  testResultsController.getmyresult.value![index];
              return MyResulttestCard(
                coursetitle: gettestresult.courseTitle.toString(),
                testtile: gettestresult.testTitle.toString(),
                testdate: gettestresult.testStart.toString(),
                onpressed: () {
                  Get.to(
                    () => MyFinalResult(
                      id: gettestresult.id.toString(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
