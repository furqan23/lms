import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:splashapp/model/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/widget/lsit.dart';
import '../../values/auth_api.dart';
import '../../widget/videocard_widget.dart';

class HomeDetail extends StatefulWidget {
  String mscatId;

  HomeDetail({super.key, required this.mscatId});

  @override
  State<HomeDetail> createState() => _VideoViewState();
}

class _VideoViewState extends State<HomeDetail> {
  List<CourseModel> courseList = [];
  bool boolData = false;

  @override
  void initState() {
    // TODO: implement initState
    getCourseAPI();
    super.initState();
  }

  void getCourseAPI() async {
    try {
      final res = await http.post(Uri.parse(AuthApi.courseApi), body: {
        "category_id": widget.mscatId,
      });
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          courseList.add(CourseModel.fromJson(mydata));
          setState(() {
            boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: boolData
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: courseList[0].data?.length,
                itemBuilder: (context, index) {
                  // return VideoCardWidget(image: 'bio.png',
                  //     title: courseList[0].data![index].catName.toString(),
                  //     subtitle1: courseList[0].data![index].name.toString(),
                  //     subtitle2: courseList[0].data![index].totalSeat.toString(),
                  //     subtitle3: courseList[0].data![index].courses![0].price.toString(),
                  //
                  // );

                  return lsit(
                    //image: 'bio.png',
                    regMethod: courseList[0].data![index].registrationMethod.toString(),
                    ePass: courseList[0].data![index].catName.toString(),
                    status: courseList[0].data![index].name.toString(),
                    dateAndTime:
                        courseList[0].data![index].totalSeat.toString(),
                    department:
                        courseList[0].data![index].courses![0].price.toString(),
                    map: courseList[0].data![index].courses,
                  );
                })
            : const Center(
                child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              )),
      ),
    );
  }
}
