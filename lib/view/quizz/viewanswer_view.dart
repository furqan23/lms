import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../model/finalresult_model.dart';

class ViewAnswer extends StatefulWidget {
  final List<FinalResultModels> finalResultList;

  const ViewAnswer({Key? key, required this.finalResultList}) : super(key: key);

  @override
  State<ViewAnswer> createState() => _ViewAnswerState();
}

class _ViewAnswerState extends State<ViewAnswer> {
  var opt1 = 'opt_1';
  var opt2 = 'opt_2';
  var opt3 = 'opt_3';
  var opt4 = 'opt_4';

  @override
  Widget build(BuildContext context) {
    print("length ${widget.finalResultList[0].data?.resultDetails?.length}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Answer'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.finalResultList.length,
        itemBuilder: (context, index) {
          FinalResultModels result = widget.finalResultList[index];
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height *.9,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: result.data!.resultDetails!.length,
                  itemBuilder: (context, subIndex) {
                    ResultDetails resultDetail =
                    result.data!.resultDetails![subIndex];

                    Color borderColorOpt1 = Colors.black;
                    Color borderColorOpt2 = Colors.black;
                    Color borderColorOpt3 = Colors.black;
                    Color borderColorOpt4 = Colors.black;

                    if (resultDetail.correctAnswer!.contains(opt1)) {
                      borderColorOpt1 = Colors.green;
                    } else if (resultDetail.givenAnswer!.contains(opt1)) {
                      borderColorOpt1 = Colors.red;
                    }

                    if (resultDetail.correctAnswer!.contains(opt2)) {
                      borderColorOpt2 = Colors.green;
                    } else if (resultDetail.givenAnswer!.contains(opt2)) {
                      borderColorOpt2 = Colors.red;
                    }

                    if (resultDetail.correctAnswer!.contains(opt3)) {
                      borderColorOpt3 = Colors.green;
                    } else if (resultDetail.givenAnswer!.contains(opt3)) {
                      borderColorOpt3 = Colors.red;
                    }

                    if (resultDetail.correctAnswer!.contains(opt4)) {
                      borderColorOpt4 = Colors.green;
                    } else if (resultDetail.givenAnswer!.contains(opt4)) {
                      borderColorOpt4 = Colors.red;
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                Border.all(color: Colors.black45)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Html(
                                    data: """
                                    <style>
                                    h2 {
                                    font-size: 24px;
                                    color: #333;
                                    border: 1px solid #ffff;
                                    text-decoration: underline;
                                     }
                                    p {
                                     font-size: 18px;
                                     margin: 10px 0;
                                     }
                                    p.opt {
                                   padding: 5px;
                                }
                                  p.opt.bold {
                                   font-weight: bold;
                                }
                                p.correct-answer {
                                color: green;
                                 }
                                p.given-answer {
                                color: red;
                                }
    </style>
    <h2>Question No ${resultDetail.questionNo.toString()}</h2>
    <p >${resultDetail.questionName.toString()}</p>
    <p class="given-answer">Given Answer: ${resultDetail.givenAnswer.toString()}</p>
    <p class="correct-answer">Correct Answer: ${resultDetail.correctedAnswer.toString()}</p>
  """,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        border: Border.all(
                                          color: borderColorOpt1,
                                        ),
                                      ),
                                      child: Html(
                                        data: """
    <style>
      h2 {
        font-size: 24px;
        color: #333;
          border: 1px solid #ffff;
        text-decoration: underline;
      }
      p {
        font-size: 18px;
        margin: 10px 0;
      }
      p.opt {
        padding: 5px;
      }
      p.opt.bold {
        font-weight: bold;
      }
      p.correct-answer {
        color: green;
      }
      p.given-answer {
        color: red;
      }
    </style>
    <p class="opt">${resultDetail.opt1.toString()}</p>
  """,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        border: Border.all(
                                          color: borderColorOpt2,
                                        ),
                                      ),
                                      child: Html(
                                        data: """
    <style>
      h2 {
        font-size: 24px;
        color: #333;
          border: 1px solid #ffff;
        text-decoration: underline;
      }
      p {
        font-size: 18px;
        margin: 10px 0;
      }
      p.opt {
        padding: 5px;
      }
      p.opt.bold {
        font-weight: bold;
      }
      p.correct-answer {
        color: green;
      }
      p.given-answer {
        color: red;
      }
    </style>
    <p class="opt">${resultDetail.opt2.toString()}</p>
  """,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        border: Border.all(
                                          color: borderColorOpt3,
                                        ),
                                      ),
                                      child: Html(
                                        data: """
    <style>
      h2 {
        font-size: 24px;
        color: #333;
          border: 1px solid #ffff;
        text-decoration: underline;
      }
      p {
        font-size: 18px;
        margin: 10px 0;
      }
      p.opt {
        padding: 5px;
      }
      p.opt.bold {
        font-weight: bold;
      }
      p.correct-answer {
        color: green;
      }
      p.given-answer {
        color: red;
      }
    </style>
    <p class="opt">${resultDetail.opt3.toString()}</p>
  """,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        border: Border.all(
                                          color: borderColorOpt4,
                                        ),
                                      ),
                                      child: Html(
                                        data: """
    <style>
      h2 {
        font-size: 24px;
        color: #333;
          border: 1px solid #ffff;
        text-decoration: underline;
      }
      p {
        font-size: 18px;
        margin: 10px 0;
      }
      p.opt {
        padding: 5px;
      }
      p.correct-answer {
        color: green;
      }
      p.given-answer {
        color: red;
      }
    </style>
    <p class="opt">${resultDetail.opt4.toString()}</p>
  """,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}