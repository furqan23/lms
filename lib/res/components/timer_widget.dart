import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/constants/constants.dart';

import 'package:timer_count_down/timer_count_down.dart';

class TimerWidgett extends StatelessWidget {
  int timee=1;
   TimerWidgett( {super.key,required this.timee,}) ;

//${time.seconds.toString()}  change to minute ..then it will show minute or change to second to do to seconds
  @override
  Widget build(BuildContext context) {
    int a=timee*60;
    return Countdown(
      seconds: a,
      build: (BuildContext context, double time) => Text("Remaining Time: ${substringsRemove(time.seconds.toString())}",style:textBoldStyleTimer),
      interval: Duration(milliseconds: 1000,),
      onFinished: () {
        print('Timer is done!');
      },
    );
  }


  String substringsRemove(String a){
    String result = a.substring(0, a.indexOf('.'));
    print(result);
    return result;
  }
}