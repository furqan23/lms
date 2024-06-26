import 'package:flutter/material.dart';

import '../values/colors.dart';

class TestCard extends StatelessWidget {
  final String id, title, start,total,test_code;

  const TestCard(
      {super.key, required this.id, required this.title, required this.start,  required this.test_code, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .29,
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
                            "Test Code: ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            test_code,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Test Date: ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            start,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Title: ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                            SizedBox(
                            width: MediaQuery.of(context).size.width * .65,
                            child: Text(title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   child: Row(
                    //     children: [
                    //       const Text(
                    //         "Duration: ",
                    //         style: TextStyle(color: Colors.grey, fontSize: 14),
                    //       ),
                    //       Text(
                    //         "$total Min",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(width: 20),
                          Container(
                            alignment: Alignment.center,
                            width: 140,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.primaryColor,
                            ),
                            child: const Text(
                              "Start Test",
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
  }
}
