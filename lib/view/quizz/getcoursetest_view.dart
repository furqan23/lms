import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/view/my_test/gettest.dart';
import 'package:splashapp/widget/dasbhoard_card_two.dart';

class GetCourseTest extends StatefulWidget {
  const GetCourseTest({super.key});

  @override
  State<GetCourseTest> createState() => _GetCourseTestState();
}

class _GetCourseTestState extends State<GetCourseTest> {
  /*----------------------- token and Model -------------*/
  String? token;
  List<MyCoursesModel> myCoursesList = [];
  bool boolData = false;
  bool boolNoData = false;

  /*------------ Call InitState ------------*/
  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Test Courses"),
      ),
      body: boolData
          ? myCoursesList[0].data?.length == 0
              ? const Center(
                  child: Text("No Record Found"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: myCoursesList[0].data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => GetTest(
                            id: myCoursesList[0].data![index].courseId!));
                      },
                      child: DashbaordCardTwo(
                        group: myCoursesList[0].data![index].courseCode,
                        id: myCoursesList[0].data![index].name,
                        courseImage: "",
                        catName: myCoursesList[0].data![index].courseTitle,
                        name: "${myCoursesList[0].data![index].firstName} ",
                        description: myCoursesList[0].data![index].name,
                        slug: myCoursesList[0].data![index].name,
                        seat: myCoursesList[0].data![index].totalSeat,
                        registermethod:
                            myCoursesList[0].data![index].registrationMethod,
                        buttonText: 'Process',
                      ),
                    );
                  })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

/*------------------ get token   ----------------*/
  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getMyCourseAPI();
  }

  /*------------------ Call GetMyCourseApi  ----------------*/

  void getMyCourseAPI() async {
    try {
      final res = await http.get(
        Uri.parse(AuthApi.getstudentCourse),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          myCoursesList.add(MyCoursesModel.fromJson(mydata));

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
