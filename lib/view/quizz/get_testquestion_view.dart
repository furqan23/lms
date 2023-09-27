// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/demo.dart';
import 'package:splashapp/model/test_question_model.dart';
import 'package:splashapp/view/home/home_screen.dart';
import '../../Controller/login_controller.dart';
import '../../model/get_test_model.dart';
import '../../values/auth_api.dart';
import '../../widget/option_widget.dart';

class QuizzView extends StatefulWidget {
  final String id;
  int totalTime,totalQuestions;

   QuizzView({super.key, required this.id, required this.totalTime, required this.totalQuestions});

  @override
  State<QuizzView> createState() => _QuizzViewState();
}

class _QuizzViewState extends State<QuizzView> {
  /* ------------- declare  variable token and Model ------------*/
  String? token;
  List<TestQuestionModel> getquestionTestList = [];
  bool boolData = false;
  String qut_name = "";
  String opt_1 = "";
  String opt_2 = "";
  String opt_3 = "";
  String opt_4 = "";
  var htmlData = """""";

  /*---------- InitState Call -----------------*/
  @override
  void initState() {
    super.initState();
    selectedRadio =
        null;
    getTokenAndFetchInvoice();
  }

  int? selectedRadio;
  List<String> question_id = [];
  List<String> givenAnswerList = [];
  List<String> CorrectAnswerList = [];


  void handleRadioValueChange(int? value) {
    setState(() {
      selectedRadio = value;
      print(selectedRadio);
      String? slted;
      if(selectedRadio==1){
        slted ="A";
      }
      else if(selectedRadio==2){
        slted ="B";
      }
      else if(selectedRadio==3){
        slted ="C";
      }
      else if(selectedRadio==4){
        slted ="D";
      }
      print(slted);
      question_id.add(getquestionTestList[0].data!.questionNo.toString());
      givenAnswerList.add(slted??"D");
      CorrectAnswerList.add(getquestionTestList[0].data!.correctAnswer.toString());
      int aaa =
          int.parse(getquestionTestList[0].data!.questionNo.toString()) + 1;
      print("aaaaaaaaaaaaaaaa  $aaa");


      widget.totalQuestions--;
      print("total question     ${widget.totalQuestions   }");
      if(widget.totalQuestions==0){
        postAnswerAPI();
        print("*********** here post answer");
      }else{
      getTestQuestionAPI(aaa);}
    });
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
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Html(data: """
                            <h3>${getquestionTestList[0].data!.questionName!}</h3>
                            ${getquestionTestList[0].data!.opt1!}
                            ${getquestionTestList[0].data!.opt2!}
                             ${getquestionTestList[0].data!.opt3!}
                              ${getquestionTestList[0].data!.opt4!}

"""),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: handleRadioValueChange,
                          ),
                          const Text('Option 1'),
                          const SizedBox(width: 20),
                          Radio(
                            value: 2,
                            groupValue: selectedRadio,
                            onChanged: handleRadioValueChange,
                          ),
                          const Text('Option 2'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: selectedRadio,
                            onChanged: handleRadioValueChange,
                          ),
                          const Text('Option 3'),
                          const SizedBox(width: 20),
                          Radio(
                            value: 4,
                            groupValue: selectedRadio,
                            onChanged: handleRadioValueChange,
                          ),
                          const Text('Option 4'),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ElevatedButton(onPressed: (){postAnswerAPI();}, child: Text("Submit")),
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  /*------------------ Fetch Token ----------------*/
  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getTestQuestionAPI(1);
  }

  /*------------------ Call GetTestQuestionApi  ----------------*/
  void getTestQuestionAPI(int questionNUmber) async {
    try {
      final Map<String, dynamic> requestData = {
        "test_id": widget.id,
        "question_no": questionNUmber.toString()
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
      getquestionTestList.clear();
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          getquestionTestList.add(TestQuestionModel.fromJson(mydata));
          // String a = getquestionTestList[0].data!.questionName.toString();
          // print("aaa    $a");
//           var htmlData = """
//    <h3>$qut_name</h3>
//     ${getquestionTestList[0].data!.questionName!}
//     $a
//     $opt_3
//     $opt_4
// """;
          setState(() {
            boolData = true;
            selectedRadio=null;
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


  // ************************** Result Api *******************
  void postAnswerAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "test_id": widget.id,
      };

      for(int i=0;i<question_id.length;i++){
        requestData.addAll({"q_id[$i]" : question_id[i]});
      }

      for(int i=0;i<givenAnswerList.length;i++){
        requestData.addAll({"given_answer[$i]" : givenAnswerList[i]});
      }

      for(int i=0;i<CorrectAnswerList.length;i++){
        requestData.addAll({"corrected_answer[$i]" : CorrectAnswerList[i]});
      }


      // final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.postAnswerApi),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token

          },
          body: requestData);


      print("************* body post answer  $requestData");
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');
      // getquestionTestList.clear();
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('**************Parsed Data: $mydata');
          bool success=mydata['success'];
          String message=mydata['message'];

          if(message=='Action Completed'){
            Get.defaultDialog(
                title: "Test Complete",
                middleText: "Attempt of the test is complete. Result will be available in result section",
                backgroundColor: Colors.green,
                titleStyle: TextStyle(color: Colors.white),
                middleTextStyle: TextStyle(color: Colors.white),
                textConfirm: "      okay      ",
                // textCancel: "Cancel",
                // cancelTextColor: Colors.white,
                confirmTextColor: Colors.green,
                buttonColor: Colors.white,
                barrierDismissible: false,
                radius: 30,
                onConfirm: () => Get.offAll(HomeScreen()),
                // content: Column(
                //   children: [
                //     Container(child:Text("Hello 1")),
                //     Container(child:Text("Hello 2")),
                //     Container(child:Text("Hello 3")),
                //   ],
                // )
            );
          }


          setState(() {
            boolData = true;
            selectedRadio=null;
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
