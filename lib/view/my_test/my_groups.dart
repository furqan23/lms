import 'dart:convert';
import 'package:splashapp/model/get_groups_model.dart';
import 'package:splashapp/values/logs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/view/my_test/gettest.dart';
import 'package:splashapp/view/mycourses/my_course_detail.dart';
import 'package:splashapp/view/mycourses/my_videos.dart';
import 'package:splashapp/widget/dasbhoard_card.dart';
import 'package:splashapp/widget/dasbhoard_card_two.dart';
import 'package:splashapp/widget/group_card.dart';

class MyGroups extends StatefulWidget {
  const MyGroups({super.key});

  @override
  State<MyGroups> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyGroups> {
  String? token;
  List<GetGroupsModel> _myCoursesList = [];
  bool boolData = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: boolData
          ? _myCoursesList[0].data?.length==0?const Center(child: Text("No Record Found"),): ListView.builder(
              shrinkWrap: true,
              itemCount: _myCoursesList[0].data?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.to(()=>GetTest(id:_myCoursesList[0].data![index].id.toString()));
                  },
                  child: GroupsCard(
                    id: "${_myCoursesList[0].data![index].groupCode}-${_myCoursesList[0].data![index].name}",
                    catName: _myCoursesList[0].data![index].catName?.toString()??"N/A",
                    name:"${_myCoursesList[0].data![index].description.toString()} ",
                    buttonText:  _myCoursesList[0].data![index].group_type.toString()   , groupCode: 'aa', registrationMethod: 'aa',
                  ),

                );
              })
          :const Center(
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
        Uri.parse(AuthApi.getGroupsText),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response groups data long');
      LogPrint(res.body.toString());

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // print('Parsed Data: $mydata');
          _myCoursesList.add(GetGroupsModel.fromJson(mydata));
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
