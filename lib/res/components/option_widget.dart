import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String option;
 // final String title;
  const OptionWidget({super.key, required this.option,
    //required this.title
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      // alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black45)),
      child: Row(
        children: [
          Text(option),
         // Text(title),
        ],
      ),
    );
  }
}
