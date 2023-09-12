import 'package:flutter/material.dart';
import 'package:splashapp/values/colors.dart';

import '../model/course_model.dart';

class lsit extends StatelessWidget {
  String ePass;
  String status;
  String dateAndTime;
  String department;
  String regMethod;
  List<Courses>? map;
  final Function() onAddToCart;

  lsit({
    required this.ePass,
    required this.status,
    required this.dateAndTime,
    required this.department,
    required this.regMethod,
    required this.map,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("date and time  $dateAndTime");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        text: "Category: $ePass ",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.grey[100],
              //   thickness: 1,
              // ),
              Container(
                height: size.height * 0.001,
                color: Colors.green[100],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        Text(
                          "Group Name:  ${status}",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Registration Method:  ${regMethod}",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Text.rich(
                  TextSpan(
                    text: "Total Seat: ",
                    //    style: textStyleWithFontGrey,
                    children: <TextSpan>[
                      TextSpan(
                        text: dateAndTime,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: (1 / .15),
                  children: List.generate(map!.length, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 9,
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              map![index].courseTitle!,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        regMethod == "single"
                            ? Container(
                                alignment: Alignment.center,
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: AppColors.primaryColor.withOpacity(.8),
                                ),
                                child: const Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                ),
              ),

              regMethod == "whole"
                  ? Center(
                      child: InkWell(
                        onTap: (){
                          onAddToCart();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: AppColors.primaryColor.withOpacity(.8),
                          ),
                          child: const Text(
                            'Add To Cart',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),

              // Center(child: SizedBox(width:300,child: Container(height:55, decoration: new BoxDecoration(
              //     color: MyColors.primaryColor,
              //     borderRadius: new BorderRadius.all(
              //        Radius.circular(30.0),
              //
              //     )
              // ), child: Center(child: Text("Apply Membership",style: TextStyle(color: Colors.white,fontSize: 17),)))))
            ],
          ),
        ),
      ),
    );
  }
}
