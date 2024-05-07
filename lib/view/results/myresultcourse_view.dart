// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/model/myresult.dart';
import 'package:splashapp/view/results/myresult_test_view.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import '../../values/auth_api.dart';
import 'package:splashapp/res/color/appcolor.dart';

class MyResultsCourse extends StatefulWidget {
  const MyResultsCourse({
    super.key,
  });

  @override
  State<MyResultsCourse> createState() => _MyResultsCourseState();
}

class _MyResultsCourseState extends State<MyResultsCourse> {
  /* ------------- declare  variable token and Model ------------*/
  String? token;
  List<MyResultModel> getresultsModelList = [];
  bool boolData = false;

  /*---------- InitState Call -----------------*/
  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('My Results'),
          ),
          body: boolData
              ? getresultsModelList[0].data?.length==0?const Center(child: Text("No Record Found"),): ListView.builder(
                  itemCount: getresultsModelList[0].data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.green.shade500,
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Group Name: ",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getresultsModelList[0]
                                                .data![index]
                                                .name
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Category: ",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getresultsModelList[0]
                                                .data![index]
                                                .catName
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Course: ",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getresultsModelList[0]
                                                .data?[index]
                                                .courseTitle
                                                ??"N/A",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const SizedBox(width: 20),
                                          InkWell(
                                            onTap: (){
                                              Get.to(()=>MyResultsTest(id: getresultsModelList[0].data![index].id.toString()));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 140,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: AppColors.primaryColor,
                                              ),
                                              child: const Text(
                                                "Result",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  /*------------------ Fetch Token ----------------*/
  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getMyTestAPI();

  }

  /*------------------ Call GetTestQuestionApi  ----------------*/
  void getMyTestAPI() async {
    try {
      final res = await http.get(
        Uri.parse(AuthApi.getMyResult1),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${res.statusCode}');
      // print('Response Body: ${res.body}');
      print('Response Body: ${res.body.toString()}');
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // print('Parsed Data: $mydata');
          getresultsModelList.add(MyResultModel.fromJson(mydata));

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
