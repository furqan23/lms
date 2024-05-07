import 'package:flutter/material.dart';
import '../../model/cart_model.dart';
import '../../model/course_model.dart';
import '../color/appcolor.dart';

class lsit extends StatefulWidget {
  String ePass;
  String status;
  String dateAndTime;

  String price;
  String regMethod;
  String groupcode;
  List<Courses>? map;
  String teacher;
  final Function() onAddToCart;

  lsit({
    required this.ePass,
    required this.price,
    required this.groupcode,
    required this.status,
    required this.dateAndTime,
    required this.regMethod,
    required this.map,
    required this.onAddToCart,
    required this.teacher,
  });

  @override
  State<lsit> createState() => _lsitState();
}

class _lsitState extends State<lsit> {
  List<CartModel> cartList = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            text: "${widget.ePass} ",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: size.height * 0.001,
                color: Colors.green[100],
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "${widget.groupcode}",
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " /${widget.status}",
                              style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${widget.regMethod}",
                          style: const TextStyle(
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
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: (1 / .24),
                  children: List.generate(widget.map!.length, (index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(

                              children: [
                                Container(
                                  height: 8,
                                  child: const CircleAvatar(
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  widget.map![index].courseTitle!,
                                  style: const TextStyle(color: Colors.grey),
                                ),

                              ],
                            ),

                            const SizedBox(width:50),
                            Text(
                              "Rs.${widget.map![index].price!}",
                              style:
                              const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            widget.regMethod == "single"
                                ? InkWell(
                                    onTap: () {
                                      widget.onAddToCart();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: AppColors.primaryColor
                                            .withOpacity(.8),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Add',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.shopping_cart,
                                            size: 18,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.map![index].firstName!}",
                                style:
                                    const TextStyle(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${widget.map![index].classtime!.padLeft(2)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 10),
              widget.regMethod == "whole"
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          widget.onAddToCart();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
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

          ],
          ),
        ),
      ),
    );
  }
}
