import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import 'package:splashapp/model/course_by_id_model.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/values/auth_api.dart';

class MyCourseDetail extends StatefulWidget {
  final String id;

  MyCourseDetail(this.id, {Key? key}) : super(key: key);

  @override
  State<MyCourseDetail> createState() => _MyCourseDetailState();
}

class _MyCourseDetailState extends State<MyCourseDetail> {
  String? token;
  List<CourseByIDModel> myCoursesList = [];
  bool boolData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Detail"),
      ),
      body: boolData
          ? myCoursesList.isNotEmpty
          ? Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8.0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Course Id: '),
                  Text(myCoursesList[0].data!.id!.toString()),
                ],
              ),
            ),
            // Display other course details similarly
          ],
        ),
      )
          : const Center(
        child: Text('No data'),
      )
          : const Center(
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
      final Map<String, dynamic> requestData = {
        "course_id": widget.id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(
        Uri.parse(AuthApi.getstudentCourseById),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          myCoursesList.add(CourseByIDModel.fromJson(mydata));
          setState(() {
            boolData = true;
          });
        } else {
          setState(() {
            boolData = true; // Setting boolData to true even if the response body is empty
          });
          print('Empty response');
        }
      } else {
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
