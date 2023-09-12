// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/model/test_question_model.dart';
import '../../Controller/login_controller.dart';
import '../../model/get_test_model.dart';
import '../../values/auth_api.dart';
import '../../widget/option_widget.dart';

class QuizzView extends StatefulWidget {
  final String id;
  const QuizzView({super.key, required this.id});

  @override
  State<QuizzView> createState() => _QuizzViewState();
}

class _QuizzViewState extends State<QuizzView> {
  /* ------------- declare  variable token and Model ------------*/
  String? token;
  List<TestQuestionModel> getquestionTestList = [];
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
                  itemCount: getquestionTestList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 20,
                          margin: const EdgeInsets.only(
                              left: 20, bottom: 10, right: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.black87,
                                    blurRadius: 2)
                              ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Question :  ",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              getquestionTestList[0]
                                  .data!
                                  .questionNo
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 130,
                          margin: const EdgeInsets.only(
                              left: 30, bottom: 10, right: 30),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.grey,
                                    blurRadius: 5)
                              ]),
                          child: Text(
                            getquestionTestList[0]
                                .data!
                                .questionName
                                .toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              'https://cdn4.iconfinder.com/data/icons/traffic-and-road-signs/128/2-512.png'),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        OptionWidget(
                            option:
                                getquestionTestList[0].data!.opt1.toString(),
                         ),
                     OptionWidget(
                            option:    getquestionTestList[0].data!.opt2.toString(),),
                       OptionWidget(option:    getquestionTestList[0].data!.opt3.toString(),),
                        OptionWidget(option:    getquestionTestList[0].data!.opt4.toString(),),
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
    getTestQuestionAPI();
  }


  /*------------------ Call GetTestQuestionApi  ----------------*/
  void getTestQuestionAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "test_id": widget.id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.getQuestionTestApi),
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
          getquestionTestList.add(TestQuestionModel.fromJson(mydata));

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
