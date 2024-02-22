import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/my_album.dart';
import 'package:splashapp/view/mycourses/my_course_detail.dart';
import 'package:splashapp/widget/dasbhoard_card_two.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  String? token;
  List<MyCoursesModel> myCoursesList = [];
  bool boolData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
      ),
      body: boolData
          ? myCoursesList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: myCoursesList[0].data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() =>
                            MyAlbum(myCoursesList[0].data![index].courseId!));
                      },
                      child: DashbaordCardTwo(
                        group: myCoursesList[0].data![index].course_code,
                        id: myCoursesList[0].data![index].name,
                        catName: myCoursesList[0].data![index].courseTitle,
                        name: "${myCoursesList[0].data![index].firstName}",
                        description: myCoursesList[0].data![index].name,
                        slug: myCoursesList[0].data![index].name,
                        seat: myCoursesList[0].data![index].totalSeat,
                        registermethod:
                            myCoursesList[0].data![index].registrationMethod,
                        buttonText: 'View Detail >',
                      ),
                    );
                  })
              : Center(
                  child: Text('No data available'),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

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

  void getMyCourseAPI() async {
    try {
      // final Map<String, dynamic> requestData = {
      //   "invoice_id": widget.invoice_id,
      // };

      // final String requestBody = jsonEncode(requestData);

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
