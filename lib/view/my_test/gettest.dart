import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashapp/model/get_test_model.dart';
import 'package:splashapp/view/quizz/get_testquestion_view.dart';
import 'package:splashapp/widget/testcard_widget.dart';

import '../../Controller/login_controller.dart';
import '../../values/auth_api.dart';
import '../../values/colors.dart';
import '../../widget/dasbhoard_card_two.dart';

class GetTest extends StatefulWidget {
  String id;
  GetTest({super.key, required this.id});

  @override
  State<GetTest> createState() => _GetTestState();
}

class _GetTestState extends State<GetTest> {
  String? token;
  List<GetTestModel> getTestList = [];
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
        title: Text("GetTest"),
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
                    // Get.to(()=>DemoApp());
                   // Get.to(()=>QuizzView(id: getTestList[0].data![index].id.toString()));
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
}
