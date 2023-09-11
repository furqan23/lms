import 'package:flutter/material.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/values/my_imgs.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String inv;
  final String createDate;
  final String Amount;
  final Status;
  final String Attachment;
  void Function() onPressed;


   CustomCardWidget({super.key,
    required this.title,
    required this.inv,
    required this.Amount,
    required this.createDate,
    required this.Status, required this.Attachment,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool istrue = false;
    final h = MediaQuery
        .of(context)
        .size
        .height;
    final w = MediaQuery
        .of(context)
        .size
        .width;
    return InkWell(
      onTap: onPressed,
      child: ExpansionTile(
        leading: Text(title),
        title: Row(
          children: [
            Column(
              children: [
                Text("Inv"),
                SizedBox(height: h * 0.02),
                Text(inv),
              ],
            ),
            SizedBox(width: w * 0.05),

            Column(
              children: [
                Text("createDate"),
                SizedBox(height: h * 0.02),
                Text(createDate),
              ],
            ),

            SizedBox(width: w * 0.05),
            Column(
              children: [
                Text("Amount"),
                SizedBox(height: h * 0.02),
                Text(Amount),
              ],
            ),


          ],
        ),

        childrenPadding: EdgeInsets.all(20),
        //expandedAlignment: Alignment.,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text("Status"),
                  SizedBox(height: h * 0.02),
                  Container(
                    alignment: Alignment.center,
                    width: w * .18,
                    height: h * .030,
                    decoration: BoxDecoration(
                      color: istrue == true ? AppColors.primaryColor : Colors
                          .red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      Status, style: TextStyle(color: Colors.white),),),
                ],
              ),
              // SizedBox(width: w * 0.05),
              // Column(
              //   children: [
              //     Text("Attachment"),
              //     SizedBox(height: h * 0.02),
              //     Text(Attachment,style: TextStyle(color: AppColors.lightblue),)
              //   ],
              // ),

              SizedBox(width: w * 0.05),
              Column(
                children: [

                  Text("Actions"),
                  SizedBox(height: h * 0.01),
                  Row(
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          color: Colors.green,
                          child: Icon(Icons.note,color: AppColors.whiteColor,)),
                      SizedBox(width: w * 0.01),
                      Container(
                          width: 30,
                          height: 30,
                          color: Colors.red,
                          child: Icon(Icons.upload_rounded,color: AppColors.whiteColor,))
                    ],
                  ),
                ],
              ),
            ],
          ),


        ],
      ),
    );
  }


}
