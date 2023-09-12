import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/model/myresult.dart';
import '../../Controller/login_controller.dart';
import '../../values/auth_api.dart';
class MyResult extends StatefulWidget {

  const MyResult({super.key,});

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
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
            title: const Text('Quizz'),
          ),
          body: boolData
              ? ListView.builder(
              itemCount: getresultsModelList[0].data?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 15),
                Text(getresultsModelList[0].data![index].name.toString()),


                  ],
                );
              })
              : Center(
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


      final res = await http.get(Uri.parse(AuthApi.getMyResultApi),
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

