import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/values/colors.dart';

import '../../Controller/cart_controller.dart';
import '../../Controller/login_controller.dart';
import '../../model/cart_model.dart';
import '../../values/auth_api.dart';

class CartScreen extends StatefulWidget {
  final List<CartModel> cartList;

  const CartScreen({super.key, required this.cartList});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.put(CartController());
  int quantity = 1;
  List<String> course_id = [];
  List<String> group_id = [];
  List<String> category_id = [];
  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
    //postAnswerAPI();
  }

  List<InvoiceModel> invoiceList = [];
  String course = 'course';
  bool boolData = false;
  String? token;
  @override
  Widget build(BuildContext context) {
    // Calculate the total balance by summing up the prices of all items in the cart
    double totalBalance =
        widget.cartList.fold(0.0, (double sum, CartModel cartItem) {
      return sum + cartItem.price;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              child: ListView.builder(
                itemCount: widget.cartList.length,
                itemBuilder: (context, index) {
                  final cartItem = widget.cartList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("group_id : ${cartItem.groupId.toString()}"),
                          Text("course_id :  ${cartItem.courseId.toString()}"),
                          Text(
                              "category_Id : ${cartItem.categoryid.toString()}"),
                          Text("Course_title: ${cartItem.courseTitle}"),
                          Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

// ...

// Inside your widget
          Expanded(
            flex: 0,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() => Text(
                                    'Total Amount: \$${cartController.totalBalance.value.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cartController.decrementQuantity(
                                          widget.cartList[0].price);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                  Obx(() => Text(cartController.quantity.value
                                      .toString())), // Display the quantity from the controller
                                  InkWell(
                                    onTap: () {
                                      cartController.incrementQuantity(
                                          widget.cartList[0].price);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ).then((value) {
                      // No need to update the actual quantity and totalBalance here
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Text('Test'),
                  ),
                ),
              ),
            ),
          ),

          // Display the total balance at the bottom of the screen
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Amount: \$${totalBalance.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              //  getInvoiceID();
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.tprimaryColor,
              ),
              child: const Text(
                'Invoice ID',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    postInvoiceAPI();
  }

  // void getInvoiceID() async {
  //   try {
  //     List<Map<String, dynamic>> requestDataList = [];
  //
  //     for (int i = 0; i < widget.cartList.length; i++) {
  //       Map<String, dynamic> cartData = {
  //         "course_id[$i]": widget.cartList[i].courseId,
  //         "group_id[$i]": widget.cartList[i].groupId,
  //         "category_id[$i]": widget.cartList[i].categoryid,
  //         'fee_type[$i]': course,
  //       };
  //       requestDataList.add(cartData);
  //
  //  Add this print statement to see the cartData for each item
  // print('Cart Data for Item $i: $cartData');
  // }
  //
  // final String requestBody = jsonEncode(requestDataList);
  //
  // final res = await http.post(
  //   Uri.parse(AuthApi.createInvoiceid),
  //   headers: {
  //     'Authorization': 'Bearer $token', // Use the retrieved token
  //     'Content-Type': 'application/json',
  //   },
  //   body: requestBody,
  // );
  //
  // print('Response Status Code: ${res.statusCode}');
  // print('Response Body: ${res.body}');
  //
  // if (res.statusCode == 200) {
  //   if (res.body.isNotEmpty) {
  //     final mydata = jsonDecode(res.body);
  //     print('Parsed Data: $mydata');
  //     invoiceList.add(InvoiceModel.fromJson(mydata));
  //     setState(() {
  //       boolData = true;
  //     });
  //   } else {
  //     print('Error: Empty response');
  //        Handle empty response here
  // }
  // } else {
  //   print('Error: ${res.statusCode}');
  //    Handle other HTTP status codes here
  // }
  // } catch (e) {
  //   print('Error: $e');
//      Handle exceptions here
  // }
  // }

  void postInvoiceAPI() async {
    try {
      Map<String, dynamic> requestData = {
        "course_id[0]": widget.cartList[0].courseId,
        "group_id[0]": widget.cartList[0].groupId,
        "category_id[0]": widget.cartList[0].categoryid,
        'fee_type[0]': course,
      };

      for (int i = 0; i < course_id.length; i++) {
        requestData.addAll({"q_id[$i]": course_id[i]});
      }

      for (int i = 0; i < category_id.length; i++) {
        requestData.addAll({"category_id[$i]": category_id[i]});
      }

      for (int i = 0; i < group_id.length; i++) {
        requestData.addAll({"group_id[$i]": group_id[i]});
      }

      // final String requestBody = jsonEncode(requestData);

      final res = await http.post(Uri.parse(AuthApi.createInvoiceid),
          headers: {
            'Authorization': 'Bearer $token', // Use the retrieved token
          },
          body: requestData);

      print("************* body Create Invoice Id $requestData");
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');
      // getquestionTestList.clear();
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('**************Parsed Data: $mydata');
          bool success = mydata['success'];
          String message = mydata['message'];
        } else {
          throw Exception('Empty response');
        }
      } else {
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
