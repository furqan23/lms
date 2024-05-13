import 'package:flutter/material.dart';

class MyResulttestCard extends StatelessWidget {
  final String coursetitle;
  final String testtile;
  final String testdate;
  final VoidCallback onpressed;
  const MyResulttestCard(
      {super.key,
      required this.coursetitle,
      required this.testtile,
      required this.testdate,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text("CourseTitle : "),
                Text(coursetitle),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text("TestTile : "),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .74,
                    child: Text(
                      testtile,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * .02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text("Test Date : "),
                Text(testdate),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onpressed,
            child: const Text("View Results"),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
