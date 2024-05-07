import 'package:flutter/material.dart';

import '../color/appcolor.dart';


class CustomCardWidget extends StatelessWidget {
  final String title;
  final String inv;
  final String refid;
  final String createDate;
  final String Amount;
  final Status;
  final String Attachment;
  void Function() onPressed;

  CustomCardWidget({
    super.key,
    required this.title,
    required this.inv,
    required this.refid,
    required this.Amount,
    required this.createDate,
    required this.Status,
    required this.Attachment,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool istrue = false;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPressed,
      child: ExpansionTile(
        leading: Text(title),
        title: Row(
          children: [
            Column(
              children: [
                const Text("Inv", style: TextStyle(fontSize: 15)),
                SizedBox(height: h * 0.02),
                Text(inv, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(width: w * 0.02),
            Column(
              children: [
                const Text("Ref Id", style: TextStyle(fontSize: 15)),
                SizedBox(height: h * 0.02),
                Text(
                  refid,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(width: w * 0.02),
            Column(
              children: [
                const Text("createDate", style: TextStyle(fontSize: 14)),
                SizedBox(height: h * 0.02),
                Text(createDate, style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(width: w * 0.02),
            Column(
              children: [
                const Text(
                  "Amount",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: h * 0.02),
                Text(
                  Amount,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),

        childrenPadding: const EdgeInsets.all(20),
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
                      color:
                          istrue == true ? AppColors.primaryColor : Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      Status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
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

              SizedBox(width: w * 0.04),
              Column(
                children: [
                  const Text("Actions"),
                  SizedBox(height: h * 0.01),
                  Row(
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          color: Colors.green,
                          child: const Icon(
                            Icons.note,
                            color: AppColors.whiteColor,
                          )),
                      SizedBox(width: w * 0.01),
                      Container(
                        width: 30,
                        height: 30,
                        color: Colors.red,
                        child: const Icon(
                          Icons.upload_rounded,
                          color: AppColors.whiteColor,
                        ),
                      ),
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
