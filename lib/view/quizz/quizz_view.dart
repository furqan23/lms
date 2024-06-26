// ignore_for_file: deprecated_member_use, non_constant_identifier_names, must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:splashapp/model/test_question_model.dart';
import 'package:splashapp/view/home/home_screen.dart';
import 'package:splashapp/view/results/myfinal_result_view.dart';
import 'package:splashapp/widget/show_load_indicator.dart';
import 'package:splashapp/widget/timer_widget.dart';
import '../../Controller/login_controller.dart';
import '../../values/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizzView extends StatefulWidget {
  final String id;
  int totalTime, totalQuestions;

  QuizzView(
      {super.key,
        required this.id,
        required this.totalTime,
        required this.totalQuestions});

  @override
  State<QuizzView> createState() => _QuizzViewState();
}

class _QuizzViewState extends State<QuizzView> {
  late Box skippedQuestionsBox;


  List<int> skippedQuestionsIds = [];




  /* ------------- declare  variable token and Model ------------*/
  String? token;
  List<TestQuestionModel> getquestionTestList = [];
  bool boolData = false;
  bool skipOnceSnackbarBool = false;
  String qut_name = "";
  String opt_1 = "";
  String opt_2 = "";
  String opt_3 = "";
  String opt_4 = "";
  var htmlData = """""";

  /*---------- InitState Call -----------------*/
  int skipQLngth=0;
  int? selectedRadio;
  List<String> question_id = [];
  List<String> givenAnswerList = [];
  List<String> CorrectAnswerList = [];


  @override
  void initState() {
    super.initState();
    selectedRadio = null;
    getTokenAndFetchInvoice();
  }


  void handleRadioValueChange(int? value,bool skipBool) {
    // if(skipBool){
    //   int aaa =
    //       int.parse(getquestionTestList[0].data!.questionNo.toString()) ;
    //   print("aaaaaaaaaaaaaaaa  $aaa");
    //   getTestQuestionAPI(aaa);
    //
    // }else {
      setState(() {
        selectedRadio = value;
        print(selectedRadio);
        String? slted;
        if (selectedRadio == 1) {
          slted = "opt_1";
          widget.totalQuestions--;
        } else if (selectedRadio == 2) {
          widget.totalQuestions--;
          slted = "opt_2";
        } else if (selectedRadio == 3) {
          widget.totalQuestions--;
          slted = "opt_3";
        } else if (selectedRadio == 4) {
          widget.totalQuestions--;
          slted = "opt_4";
        }else{
          widget.totalQuestions--;
        }
        if (widget.totalQuestions <= 0) {


          if (skippedQuestionsIds.isNotEmpty) {

            print('skip skip quesiton not empty');

              skipOnceSnackbarBool=true;

            if(skipQLngth==0){
              print('skip length==0');
              postAnswerAPI();
            }else {
              print("lenth skipQuestionId ${skippedQuestionsIds.length}");
              question_id.add(getquestionTestList[0].data!.id.toString());
              givenAnswerList.add(slted ?? "opt_1");
              CorrectAnswerList.add(
                  getquestionTestList[0].data!.correctAnswer.toString());

              // for (String id in question_id) {
              //   print("skip question id list $id");
              // }
              int _aaa =
              int.parse(skippedQuestionsIds[skipQLngth - 1].toString());
              print("skip id  $_aaa");
              skipQLngth--;
              getTestQuestionAPI(_aaa);
            }
          } else {
            postAnswerAPI();
          }

          print("*********** here post answer");
        } else {
          print(slted);
          if(!skipBool) {
            question_id.add(getquestionTestList[0].data!.id.toString());
            givenAnswerList.add(slted ?? "opt_1");
            CorrectAnswerList.add(
                getquestionTestList[0].data!.correctAnswer.toString());
            int aaa =
                int.parse(getquestionTestList[0].data!.questionNo.toString()) + 1;
            print("aaaaaaaaaaaaaaaa  $aaa");

            print("total question now    ${widget.totalQuestions}");
            // widget.totalQuestions--;
            getTestQuestionAPI(aaa);
          }else{
            int aaa =
                int.parse(getquestionTestList[0].data!.questionNo.toString()) + 1;
            getTestQuestionAPI(aaa);
          }


        }
      });
    // }
  }


  @override
  Widget build(BuildContext context) {
    print("total question ${widget.totalQuestions}");
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(

      onWillPop:  () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Quiz'),
            // actions: [
              // IconButton(
              //   onPressed: () {
              //     // _skipQuestion();
              //   },
              //   icon: const Icon(Icons.skip_next),
              // ),
            // ],
          ),
          body: boolData
              ?
          // ListView.builder(
          //   itemCount: getquestionTestList.length,
          //   itemBuilder: (context, index) {
          //     return
            SingleChildScrollView(
              child: Column(
                  children: [
                    TimerWidgett(timee:  widget.totalTime),
                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Html(data: """
                 
          <h2>Question No ${getquestionTestList[0].data!.questionNo!}</h2>
         
          <p>${getquestionTestList[0].data!.questionName!}</p>
           ${getquestionTestList[0].data!.opt1!}
           ${getquestionTestList[0].data!.opt2!}
           ${getquestionTestList[0].data!.opt3!}
           ${getquestionTestList[0].data!.opt4!}
        
      """),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRadioButton(
                            title: "   Option A   ",
                            isSelected: selectedRadio == 1,
                            onSelect: (bool selected) {
                              handleRadioValueChange(selected ? 1 : null,false);
                            },
                          ),
                          const SizedBox(width: 20),
                          CustomRadioButton(
                            title: "   Option B   ",
                            isSelected: selectedRadio == 2,
                            onSelect: (bool selected) {
                              handleRadioValueChange(selected ? 2 : null,false);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRadioButton(
                            title: "   Option C   ",
                            isSelected: selectedRadio == 3,
                            onSelect: (bool selected) {
                              handleRadioValueChange(selected ? 3 : null,false);
                            },
                          ),
                          const SizedBox(width: 20),
                          CustomRadioButton(
                            title: "   Option D   ",
                            isSelected: selectedRadio == 4,
                            onSelect: (bool selected) {
                              handleRadioValueChange(selected ? 4 : null,false);
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              postAnswerAPI();
                            },
                            child: const Text("  Submit  "),
                          ),
                        ),
                        skipOnceSnackbarBool? const Text("Skip Questions Started \n No more skipping allowed",style: TextStyle(color: Colors.red,),):
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              int _aaa =
                                  int.parse(getquestionTestList[0].data!.questionNo.toString()) ;
                              skippedQuestionsIds.add(_aaa);
                              skipQLngth++;
                             handleRadioValueChange( 44 ,true);
                            },
                            child:  Text( "  Skip  "),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            )

              : const Center(
            child: CircularProgressIndicator(),
          ),
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
    showLoadingIndicator(context);
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
        Get.back();
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
            selectedRadio = null;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        Get.back();
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      Get.back();
      print(e.toString());
    }
  }


  /************************** Result Api *******************/
  void postAnswerAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "test_id": widget.id,
      };

      for (int i = 0; i < question_id.length; i++) {
        requestData.addAll({"q_id[$i]": question_id[i]});
      }

      for (int i = 0; i < givenAnswerList.length; i++) {
        requestData.addAll({"given_answer[$i]": givenAnswerList[i]});
      }

      for (int i = 0; i < CorrectAnswerList.length; i++) {
        requestData.addAll({"corrected_answer[$i]": CorrectAnswerList[i]});
      }

      // final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.postAnswerApi),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
          },
          body: requestData);

      print("************* body post answer  $requestData");
      print('Response Status Code: ${res.statusCode}');
      print('Response Body quiz view: ${res.body}');
      // getquestionTestList.clear();
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('**************Parsed Data: $mydata');
          bool success = mydata['success'];
          String message = mydata['message'];

          if (message == 'Action Completed') {
            Get.defaultDialog(
              title: "Test Complete",
              middleText:
              "Attempt of the test is complete. Result will be available in result section",
              backgroundColor: Colors.green,
              titleStyle: const TextStyle(color: Colors.white),
              middleTextStyle: const TextStyle(color: Colors.white),
              textConfirm: "      OKAY      ",
              // textCancel: "Cancel",
              // cancelTextColor: Colors.white,
              confirmTextColor: Colors.green,
              buttonColor: Colors.white,
              barrierDismissible: false,
              radius: 30,
              // onConfirm: () => Get.off(() => MyFinalResult(
              //       id: getquestionTestList[0].data!.id!,

                onConfirm: (){
                Get.back();
                Get.back();
                  Get.off(() => MyFinalResult(
                    id: widget.id,
                    //question: getquestionTestList[0]!.data!.questionNo,
                  ));
                },
                // Get.offNamedUntil('/testResult?param1=value1&param2=value2', (route) => route == '/main');

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
            selectedRadio = null;
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
  // List<Map<String, dynamic>> _getSkippedQuestions() {
  //   List<Map<String, dynamic>> skippedQuestions = [];
  //   for (var i = 0; i < skippedQuestionsBox.length; i++) {
  //     var questionInfo = skippedQuestionsBox.getAt(i);
  //     if (questionInfo != null) {
  //       skippedQuestions.add(questionInfo as Map<String, dynamic>);
  //     }
  //   }
  //   return skippedQuestions;
  // }
  // void printSkippedQuestions() {
  //   List<Map<String, dynamic>> skippedQuestions = _getSkippedQuestions();
  //   for (var i = 0; i < skippedQuestions.length; i++) {
  //     var questionData = skippedQuestions[i]['questionData'];
  //     var givenAnswers = skippedQuestions[i]['givenAnswerList'];
  //     var correctAnswers = skippedQuestions[i]['correctAnswerList'];
  //
  //     print('Skipped Question ${i + 1}:');
  //     print('Question: ${questionData['questionName']}');
  //     print('Given Answers: $givenAnswers');
  //     print('Correct Answers: $correctAnswers');
  //     print('\n');
  //   }
  // }


  // void checkSavedData() {
  //   print('Number of items in skippedQuestionsBox: ${skippedQuestionsBox.length}');
  //   for (var i = 0; i < skippedQuestionsBox.length; i++) {
  //     var questionInfo = skippedQuestionsBox.getAt(i);
  //     print('Item $i:');
  //     print(questionInfo);
  //   }
  // }
  // void _skipQuestion() {
  //   var questionData = getquestionTestList[0].data;
  //   // Create a map containing all necessary information
  //   Map<String, dynamic> questionInfo = {
  //     'questionData': questionData,
  //     'givenAnswerList': givenAnswerList,
  //     'correctAnswerList': CorrectAnswerList,
  //   };
  //
  //   // Add the map to the Hive box
  //   skippedQuestionsBox.add(questionInfo);
  //
  //   // Check the saved data
  //   checkSavedData();
  // }

}

class CustomRadioButton extends StatefulWidget {
  final String title;
  final bool isSelected;
  final Function(bool)? onSelect;

  CustomRadioButton({
    required this.title,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (widget.onSelect != null) {
          widget.onSelect!(!widget.isSelected);
        }
      },
      child: Text(
        widget.title,
        style: TextStyle(
          color: (widget.isSelected ? Colors.green : Colors.brown),
        ),
      ),
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: widget.isSelected ? Colors.green : Colors.red,
              ))),
    );
  }



}
