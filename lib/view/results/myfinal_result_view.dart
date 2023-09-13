import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Controller/login_controller.dart';
import '../../model/finalresult_model.dart';
import '../../values/auth_api.dart';

class MyFinalResult extends StatefulWidget {
  final String id;
  const MyFinalResult({super.key, required this.id});

  @override
  State<MyFinalResult> createState() => _MyFinalResultState();
}

class _MyFinalResultState extends State<MyFinalResult> {
  /* ------------- declare  variable token and Model ------------*/
  String? token;
  List<FinalResultModels> getfinalresultList = [];
  bool boolData = false;

  /*---------- InitState Call -----------------*/
  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  /*------------------ Fetch Token ----------------*/
  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    getFinalResutAPI();
  }

  /*------------------ Call GetTestQuestionApi  ----------------*/
  void getFinalResutAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "test_id": widget.id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.getMyfinalResultApi),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
            'Content-Type': 'application/json',
          },
          body: requestBody);

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          getfinalresultList.add(FinalResultModels.fromJson(mydata));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyFinalResult'),
      ),
      body: boolData
          ? ListView.builder(
              itemCount: getfinalresultList[0].data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      height: 130,
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
                                      Text(
                                        "Question Name : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        getfinalresultList[0]
                                            .data![index]
                                            .questionName
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Correct Answer : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        getfinalresultList[0]
                                            .data![index]
                                            .correctedAnswer
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Given  Answer  : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        getfinalresultList[0]
                                            .data![index]
                                            .givenAnswer
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
