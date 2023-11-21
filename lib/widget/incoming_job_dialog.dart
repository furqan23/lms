import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/values/colors.dart';


import 'custom_button.dart';

class IncomingJob extends StatefulWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final String? icon;

  IncomingJob({this.text, this.color, this.textColor,this.icon});

  @override
  State<IncomingJob> createState() => _IncomingJobState();
}

class _IncomingJobState extends State<IncomingJob> {



  @override
  Widget build(BuildContext context){
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
          padding: EdgeInsets.all(20),
          height: mediaQuery.height * 0.45,
          width: mediaQuery.width * 0.85,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   "Status",
                //   style: textTheme.headlineSmall!
                //       .copyWith(fontWeight: FontWeight.w500),
                // ),

                Image.asset(
                  widget.icon!,width: 130,height: 130,

                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                 widget.text!,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w100),
                ),
               const SizedBox(
                  height: 30,
                ),

                CustomButton(
                title: "Okay",colorOne: AppColors.tbtn1, colorTwo: AppColors.tbtn2,
                onPressed: ()  {
                Get.back();
                },
                )
              ],
            ),
          )),
    );
  }
}
