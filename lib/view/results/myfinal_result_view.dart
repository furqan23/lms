import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/res/constants/constants.dart';
import 'package:splashapp/view/home/home_screen.dart';
import 'package:splashapp/view/quizz/viewanswer_view.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import '../../model/finalresult_model.dart';
import '../../values/auth_api.dart';

class MyFinalResult extends StatefulWidget {
  final String id;
  const MyFinalResult({super.key, required this.id});

  @override
  State<MyFinalResult> createState() => _MyFinalResultState();
}

class _MyFinalResultState extends State<MyFinalResult> {
  String? token;
  List<FinalResultModels> getfinalresultList = [];
  bool boolData = false;

  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    getFinalResutAPI();
  }

  void getFinalResutAPI() async {
    print("test id ${widget.id}");
    try {
      final Map<String, dynamic> requestData = {
        "test_id": widget.id,
      };

      final String requestBody = jsonEncode(requestData);
      final res = await http.post(Uri.parse(AuthApi.getMyfinalResultApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: requestBody);

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
leading: IconButton(onPressed: (){
  Get.to(()=>HomeScreen());
}, icon: Icon(Icons.arrow_back)),
        title: const Text('Result'),
        
      ),
      body: boolData
          ? ListView.builder(
        itemCount: getfinalresultList.length,
        itemBuilder: (context, index) {
          final result = getfinalresultList[index].data!;

          return Column(
            children: [
              Padding(
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
                                    const Text(
                                      "Category Name : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      result.testDetails?.catName ?? '',
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
                                      "Group Name : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      result.testDetails?.name ?? '',
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
                                    const Text(
                                      "Course Title  : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      result.testDetails?.courseTitle ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    height: 160,
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
                                      "Total Questions : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      result.resultSummery?.totalQuestions ?? '',
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
                                      "Given Answers : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      result.resultSummery?.givenAnswers ?? '',
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
                                    const Text(
                                      "Corrected Answers  : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      result.resultSummery?.correctedAnswers ?? '',
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
                                    const Text(
                                      "Wrong Answers : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      result.resultSummery?.wrongAnswers ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.to(() =>
                      ViewAnswer(finalResultList: getfinalresultList));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 280,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: const Text("View Test Answer", style: textwhiteColorStyle),
                ),
              )
            ],
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
