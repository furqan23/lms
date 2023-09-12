import 'package:flutter/material.dart';

import '../values/colors.dart';

class TestCard extends StatelessWidget {
  final String id, title, start;
  const TestCard(
      {super.key, required this.id, required this.title, required this.start});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: 150,
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
                          Text(
                            'hhh',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            "Test_title: ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            "Test_start: ",
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
