import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/album_model.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/my_course_detail.dart';
import 'package:splashapp/view/mycourses/my_videos.dart';
import 'package:splashapp/widget/album_card.dart';
import 'package:splashapp/widget/dasbhoard_card_two.dart';

class MyAlbum extends StatefulWidget {
  final String id;
  MyAlbum(this.id, {Key? key}) : super(key: key);

  @override
  State<MyAlbum> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyAlbum> {
  String? token;
  List<AlbumModel> myCoursesList = [];
  bool boolData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Course Albums"),
      ),
      body: boolData
          ? myCoursesList[0].data!.isEmpty?Center(child: Text("No Courses Available"),):ListView.builder(
              shrinkWrap: true,
              itemCount: myCoursesList[0].data?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => MyVideos(
                        myCoursesList[0].data![index].id!));
                  },
                  child: AlbumCard(
                    id: myCoursesList[0].data![index].id,
                    albam_title: myCoursesList[0].data![index].albumTitle,
                    albam_code:
                        "${myCoursesList[0].data![index].albamCode}",

                  ),
                );
              })
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
      // final Map<String, dynamic> requestData = {
      //   "invoice_id": widget.invoice_id,
      // };

      // final String requestBody = jsonEncode(requestData);

      final res = await http.post(
        Uri.parse(AuthApi.getCourseAlbum),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
        },
        body: {
          'course_id': '${widget.id}', // Use the retrieved token

        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          myCoursesList.add(AlbumModel.fromJson(mydata));
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
