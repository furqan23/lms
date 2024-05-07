import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/model/myresult.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import '../../values/auth_api.dart';

class MyResults extends StatefulWidget {
  const MyResults({super.key});

  @override
  State<MyResults> createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {
  LoginController _loginController = Get.put(LoginController());
  List<MyResultModel> resultsList = [];
  bool boolData = false;
  String? token;

  @override
  void initState() {
    // TODO: implement initState
   getMyResultAPI();
    super.initState();
  }


  /*------------------ Fetch Token ----------------*/
  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getMyResultAPI();
  }

  void getMyResultAPI() async {
    try {
      final res = await http.get(Uri.parse(AuthApi.getMyResult1));
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          resultsList.add(MyResultModel.fromJson(mydata));
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
      throw Exception('Failed to load data $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Results"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
