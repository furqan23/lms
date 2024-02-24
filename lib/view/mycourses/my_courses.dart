import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/my_album.dart';
import 'package:splashapp/widget/dasbhoard_card_two.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  String? token;
  List<Data> myCoursesList = [];
  bool boolData = true; // Initialize to true for showing loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
      ),
      body: boolData
          ? Center(
        child: CircularProgressIndicator(),
      )
          : myCoursesList.isEmpty
          ? const Center(
        child: Text('No Course available'),
      )
          : ListView.builder(
          shrinkWrap: true,
          itemCount: myCoursesList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(() => MyAlbum(myCoursesList[index].courseId!));
              },
              child: DashbaordCardTwo(
                group: myCoursesList[index].courseCode,
                id: myCoursesList[index].name,
                catName: myCoursesList[index].courseTitle,
                name: "${myCoursesList[index].firstName}",
                description: myCoursesList[index].name,
                slug: myCoursesList[index].name,
                seat: myCoursesList[index].totalSeat,
                registermethod:
                myCoursesList[index].registrationMethod,
                buttonText: 'View Detail >',
              ),
            );
          }),
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
        final mydata = jsonDecode(res.body);
        print('Parsed Data: $mydata');
        final course = MyCoursesModel.fromJson(mydata);
        setState(() {
          boolData = false; // Set to false after receiving response
          myCoursesList = course.data!;
        });
      } else {
        setState(() {
          boolData = false; // Set to false in case of error too
        });
        print('Error: ${res.statusCode}');
        throw Exception('Failed to fetch courses');
      }
    } catch (e) {
      setState(() {
        boolData = false; // Set to false in case of exception
      });
      print('Exception: $e');
    }
  }
}
