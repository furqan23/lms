import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/view/cart/confirmation_mesg.dart';

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
  int quantity = 1;
  @override
  void initState() {
    super.initState();

  }

  List<InvoiceModel> invoiceList = [];
  List<GetInvoiceByIdModel> invoiceByIdList = [];
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
                          Text("Group id : ${cartItem.groupId.toString()}"),
                          Text("Course id :  ${cartItem.courseId.toString()}"),
                          Text(
                              "Category id : ${cartItem.categoryid.toString()}"),
                          Text("Course title: ${cartItem.courseTitle}"),
                          Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    int tempQuantity = quantity; // Create a temporary variable
                    double tempTotalBalance =
                        totalBalance * quantity; // Create a temporary variable

                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total Amount: \$${tempTotalBalance.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         if (tempQuantity > 1) {
                              //           tempQuantity--;
                              //           tempTotalBalance -=
                              //               widget.cartList[0].price;
                              //         }
                              //       },
                              //       child: Container(
                              //         width: 40,
                              //         height: 40,
                              //         decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: Colors.red,
                              //         ),
                              //         child: Icon(Icons.remove),
                              //       ),
                              //     ),
                              //     Text(tempQuantity
                              //         .toString()), // Display the temporary quantity
                              //     InkWell(
                              //       onTap: () {
                              //         tempQuantity++;
                              //         tempTotalBalance +=
                              //             widget.cartList[0].price;
                              //       },
                              //       child: Container(
                              //         width: 40,
                              //         height: 40,
                              //         decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: Colors.green,
                              //         ),
                              //         child: Icon(Icons.add),
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        );
                      },
                    ).then((value) {
                      // Update the actual quantity and totalBalance after the dialog is closed
                      if (tempQuantity != quantity) {
                        setState(() {
                          quantity = tempQuantity;
                          totalBalance = tempTotalBalance;
                        });
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text('Test'),
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
              getTokenAndFetchInvoice();
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.tprimaryColor,
              ),
              child: const Text(
                'Create Invoice',
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
    // print('Token: $token');
    getInvoiceID();
  }

  void getInvoiceID() async {
    try {
      List<Map<String, dynamic>> requestDataList = [];

      for (int i = 0; i < widget.cartList.length; i++) {
        Map<String, dynamic> cartData = {
          "course_id": widget.cartList[i].courseId,
          "group_id": widget.cartList[i].groupId,
          "category_id": widget.cartList[i].categoryid,
          'fee_type': course,
          "qty":1
        };
        requestDataList.add(cartData);
      }


      final String requestBody = jsonEncode(requestDataList);

      List<Map<String, dynamic>> requestDataBody ;
      Map<String, dynamic> requestDataBodyy = {
        "bodyy": requestDataList,

      };

      print(requestDataBodyy);
      // print("${requestBody}");
      final res = await http.post(
        Uri.parse(AuthApi.createInvoiceid),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestDataBodyy),
      );


      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          invoiceList.add(InvoiceModel.fromJson(mydata));
          getShowBankInvoiceApi(invoiceList[0].data?.invoiceId.toString()??"na");
          setState(() {
            boolData = true;
          });
        } else {
          print('Error: Empty response');
          // Handle empty response here
        }
      } else {
        print('Error: ${res.statusCode}');
        // Handle other HTTP status codes here
      }
    } catch (e) {
      print('Error: $e');
      // Handle exceptions here
    }
  }



  void getShowBankInvoiceApi(String _invoiceId) async {
    try {
      // List<Map<String, dynamic>> requestDataList = [];
      // final String requestBody = jsonEncode(requestDataList);
      //
      // List<Map<String, dynamic>> requestDataBody ;
      // Map<String, dynamic> requestDataBodyy = {
      //   "bodyy": requestDataList,
      //
      // };
      // print(requestDataBodyy);
      // print("${requestBody}");

      final bodyy={
          'invoice_id':_invoiceId,
      };

      final res = await http.post(
        Uri.parse("${AuthApi.getInvoiceByIdApi}"),

        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
         body: jsonEncode(bodyy),
      );


      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // print('Parsed Data: $mydata');
          invoiceByIdList.add(GetInvoiceByIdModel.fromJson(mydata));
          Get.to(()=>ConfirmationMesg(data:invoiceByIdList[0].data?.pMethods?[0].description??"na"));
          //
          // setState(() {
          //   boolData = true;
          // });
        } else {
          print('Error: Empty response');
          // Handle empty response here
        }
      } else {
        print('Error: ${res.statusCode}');
        // Handle other HTTP status codes here
      }
    } catch (e) {
      print('Error: $e');
      // Handle exceptions here
    }
  }


}
