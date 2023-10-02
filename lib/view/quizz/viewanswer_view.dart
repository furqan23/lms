import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../model/finalresult_model.dart';

class ViewAnswer extends StatefulWidget {
  final List<FinalResultModels> finalResultList;

  const ViewAnswer({super.key, required this.finalResultList});

  @override
  State<ViewAnswer> createState() => _ViewAnswerState();
}

class _ViewAnswerState extends State<ViewAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Answer'),
        ),
        body: ListView.builder(
          itemCount: widget.finalResultList.length,
          itemBuilder: (context, index) {
            FinalResultModels result = widget.finalResultList[index];
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: result.data!.resultDetails!.length,
                    itemBuilder: (context, subIndex) {
                      ResultDetails resultDetail =
                          result.data!.resultDetails![subIndex];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.red)),
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
                                          border:
                                              Border.all(color: Colors.black),
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
                                          border:
                                              Border.all(color: Colors.black45),
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
                                          border:
                                              Border.all(color: Colors.black45),
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
                                          border:
                                              Border.all(color: Colors.black45),
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
        ));
  }
}
