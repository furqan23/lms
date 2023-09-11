import 'package:flutter/material.dart';

import '../../widget/option_widget.dart';

class QuizzView extends StatelessWidget {
  const QuizzView({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(

          title: const Text('Quizz'),
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 20,
              margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
            const Text(
              'Question # 1 / 20',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 130,
              margin: const EdgeInsets.only(left: 30, bottom: 10, right: 30),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(offset: Offset(0, 0), color: Colors.grey, blurRadius: 5)
              ]),
              child: const Text(
                'What does this Sign mean?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://cdn4.iconfinder.com/data/icons/traffic-and-road-signs/128/2-512.png'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const OptionWidget(option: 'A: ', title: ' Left stop '),
            const OptionWidget(option: 'B: ', title: ' No Right Turn'),
            const OptionWidget(option: 'C: ', title: ' Right Turn'),
          ],
        ),
      ),
    );
  }
}
