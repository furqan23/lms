
 import 'package:flutter/material.dart';

void showLoadingIndicator(BuildContext context) {


  AlertDialog alert=AlertDialog(
        content:  Row(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
          ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );




}