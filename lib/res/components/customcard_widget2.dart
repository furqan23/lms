import 'package:flutter/material.dart';

import '../color/appcolor.dart';

class CustomCardWidget2 extends StatelessWidget {
  final String title;
  final String inv;
  final String refid;
  final String createDate;
  final String Amount;
  final Status;
  final String Attachment;
  void Function() onPressed;

  void Function() onClcik;

  CustomCardWidget2({
    super.key,
    required this.onClcik,
    required this.title,
    required this.inv,
    required this.refid,
    required this.Amount,
    required this.createDate,
    required this.Status,
    required this.Attachment,
    required this.onPressed,
  });

  Container getStatusContainer(String status, double w, double h) {
    return Container(
      alignment: Alignment.center,
      width: w * .18,
      height: h * .030,
      decoration: BoxDecoration(
        color: getStatusColor(status),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Color getStatusColor(String status) {
    return status.toLowerCase() == 'paid' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    bool istrue = false;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: h * .3,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.green.shade500,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Text(
                            "Id : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "$inv",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Text(
                            "Ref Id : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "$refid",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Text(
                            "createDate : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "$createDate",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Text(
                            "Amount : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "$Amount",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Text(
                            "Status :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          getStatusContainer(Status, w, h),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: onPressed,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: onClcik,
                              child: Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: AppColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "View Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: w * 0.02),
                                    const Icon(
                                      Icons.note,
                                      color: AppColors.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
