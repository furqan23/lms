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
  int currentIndex = 0;

  void goToNextQuestion() {
    if (currentIndex < widget.finalResultList.length ) {
      setState(() {
        currentIndex++;
        print(currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= widget.finalResultList.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('View Answer'),
        ),
        body: const Center(
          child: Text('All questions have been displayed.'),
        ),
      );
    }

    final resultDetails = widget.finalResultList[currentIndex].data!.resultDetails![0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Answer'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(10),
            child: Html(
              data: """
                <h2>Question No ${resultDetails.questionNo.toString()}</h2>
                <p>${resultDetails.questionName.toString()}</p>
                <p>${resultDetails.opt1.toString()}</p>
                <p>${resultDetails.opt2.toString()}</p>
                <p>${resultDetails.opt3.toString()}</p>
                <p>${resultDetails.opt4.toString()}</p>
                Given Answer: ${resultDetails.givenAnswer.toString()}
                Correct Answer: ${resultDetails.correctedAnswer.toString()}
              """,
            ),
          ),
          ElevatedButton(
            onPressed: goToNextQuestion,
            child: Text('Next Question'),
          ),
        ],
      ),
    );
  }
}
