import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/values/my_imgs.dart';
import 'package:splashapp/view/cart/confirmation_mesg.dart';
import 'package:splashapp/view/test_pay/test_pay.dart';
import 'package:splashapp/widget/incoming_payment_method_dialog.dart';
import 'package:splashapp/widget/show_load_indicator.dart';

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
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
  }

  List<CartModel> cartList = [];
  List<InvoiceModel> invoiceList = [];
  List<GetInvoiceByIdModel> invoiceByIdList = [];
  String course = 'course';
  String test = 'test'; // test
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
        actions: [
          // IconButton(
          //   onPressed: () {
          //     if (widget.cartList.isNotEmpty) {
          //       print('before sending let' + widget.cartList.length.toString());
          //          Get.to(() => Khushal(
          //              cartList: widget.cartList,
          //          ));
          //     } else {
          //       // Handle the case when the cart list is empty
          //       // For example, show a snackbar or an alert to inform the user.
          //     }
          //   },
          //   icon: const Icon(Icons.payments_outlined),
          // ),
        ],
      ),
      // floatingActionButton: Stack(
      //   children: [
      //     Positioned(
      //       bottom: 90,
      //       left: 300,
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           int tempQuantity = cartController
      //               .quantity.value; // Create a temporary variable
      //           double tempTotalBalance = cartController.totalBalance.value *
      //               cartController.quantity.value;
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return AlertDialog(
      //                 // title: const Text('Your Dialog Title'),
      //                 content: SingleChildScrollView(
      //                   child: Align(
      //                     alignment: Alignment.topRight,
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Column(
      //                         children: [
      //                           Obx(() => Text(
      //                                 'Total Amount: \$${cartController.totalBalance.value.toStringAsFixed(0)}',
      //                                 style: const TextStyle(
      //                                   fontSize: 20,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               )),
      //                           const SizedBox(height: 10),
      //                           Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceEvenly,
      //                             children: [
      //                               InkWell(
      //                                 onTap: () {
      //                                   cartController.decrementQuantity();
      //                                 },
      //                                 child: Container(
      //                                   width: 40,
      //                                   height: 40,
      //                                   decoration: const BoxDecoration(
      //                                     shape: BoxShape.circle,
      //                                     color: Colors.red,
      //                                   ),
      //                                   child: const Icon(Icons.remove),
      //                                 ),
      //                               ),
      //                               Obx(() => Text(cartController.quantity.value
      //                                   .toString())), // Display the quantity from the controller
      //                               InkWell(
      //                                 onTap: () {
      //                                   cartController.incrementQuantity();
      //                                 },
      //                                 child: Container(
      //                                   width: 40,
      //                                   height: 40,
      //                                   decoration: const BoxDecoration(
      //                                     shape: BoxShape.circle,
      //                                     color: Colors.green,
      //                                   ),
      //                                   child: const Icon(Icons.add),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           const SizedBox(height: 20),
      //                           InkWell(
      //                             onTap: () {
      //                               getTokenAndFetchInvoice();
      //                             },
      //                             child: Container(
      //                               alignment: Alignment.center,
      //                               width: 90,
      //                               height: 40,
      //                               decoration: BoxDecoration(
      //                                   color: Colors.red,
      //                                   borderRadius:
      //                                       BorderRadius.circular(10)),
      //                               child: const Text("create"),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 actions: <Widget>[
      //                   TextButton(
      //                     child: const Text('Close'),
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                   ),
      //                 ],
      //               );
      //             },
      //           );
      //         },
      //         child: const Icon(Icons.add),
      //         backgroundColor: Colors.blue, // Replace with your desired color
      //       ),
      //     ),
      //   ],
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
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
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
    // getInvoiceID2();
  }

  void getInvoiceID() async {
    showLoadingIndicator(context);
    try {
      List<Map<String, dynamic>> requestDataList = [];

      for (int i = 0; i < widget.cartList.length; i++) {
        Map<String, dynamic> cartData = {
          "course_id": widget.cartList[i].courseId,
          "group_id": widget.cartList[i].groupId,
          "category_id": widget.cartList[i].categoryid,
          'fee_type': course,
          "qty": 1
        };
        requestDataList.add(cartData);

        print(requestDataList);
      }

      final String requestBody = jsonEncode(requestDataList);

      List<Map<String, dynamic>> requestDataBody;
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
        // Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          invoiceList.add(InvoiceModel.fromJson(mydata));
          getShowBankInvoiceApi(
              invoiceList[0].data?.invoiceId.toString() ?? "na");
          setState(() {
            boolData = true;
          });
        } else {
          Get.back();
          print('Error: Empty response');
          // Handle empty response here
        }
      } else {
        // Get.back();
        print('Error: ${res.statusCode}');
        // Handle other HTTP status codes here
      }
    } catch (e) {
      Get.back();
      print('Error: $e');
      // Handle exceptions here
    }
  }

  void getShowBankInvoiceApi(String _invoiceId) async {
    try {
      final bodyy = {
        'invoice_id': _invoiceId,
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
        Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // print('Parsed Data: $mydata');
          invoiceByIdList.add(GetInvoiceByIdModel.fromJson(mydata));
          Get.dialog(IncomingPaymentMethodDialog(
            invoiceId: mydata["id"],
            status: mydata["status"],
            text: mydata["message"],
            invoiceByIdList: invoiceByIdList,
          ));

          //
          // setState(() {
          //   boolData = true;
          // });
        } else {
          Get.back();
          print('Error: Empty response');
          // Handle empty response here
        }
      } else {
        Get.back();
        print('Error: ${res.statusCode}');
        // Handle other HTTP status codes here
      }
    } catch (e) {
      Get.back();
      print('Error: $e');
      // Handle exceptions here
    }
  }

  // void getInvoiceID2() async {
  //   showLoadingIndicator(context);
  //   try {
  //     List<Map<String, dynamic>> requestDataList = [];
  //
  //     for (int i = 0; i < widget.cartList.length; i++) {
  //       Map<String, dynamic> cartData = {
  //         "course_id": widget.cartList[i].courseId,
  //         "group_id": widget.cartList[i].groupId,
  //         "category_id": widget.cartList[i].categoryid,
  //         'fee_type': test,
  //         "qty": 1
  //       };
  //       requestDataList.add(cartData);
  //
  //       print(requestDataList);
  //     }
  //
  //     final String requestBody = jsonEncode(requestDataList);
  //
  //     List<Map<String, dynamic>> requestDataBody;
  //     Map<String, dynamic> requestDataBodyy = {
  //       "bodyy": requestDataList,
  //     };
  //
  //     print(requestDataBodyy);
  //     // print("${requestBody}");
  //     final res = await http.post(
  //       Uri.parse(AuthApi.createInvoiceid),
  //       headers: {
  //         'Authorization': 'Bearer $token', // Use the retrieved token
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(requestDataBodyy),
  //     );
  //
  //     print('Response Status Code: ${res.statusCode}');
  //     print('Response Body: ${res.body}');
  //
  //     if (res.statusCode == 200) {
  //       // Get.back();
  //       if (res.body.isNotEmpty) {
  //         final mydata = jsonDecode(res.body);
  //         print('Parsed Data: $mydata');
  //         invoiceList.add(InvoiceModel.fromJson(mydata));
  //         getShowBankInvoiceApi2(
  //             invoiceList[0].data?.invoiceId.toString() ?? "na");
  //         setState(() {
  //           boolData = true;
  //         });
  //       } else {
  //         Get.back();
  //         print('Error: Empty response');
  //         // Handle empty response here
  //       }
  //     } else {
  //       // Get.back();
  //       print('Error: ${res.statusCode}');
  //       // Handle other HTTP status codes here
  //     }
  //   } catch (e) {
  //     Get.back();
  //     print('Error: $e');
  //     // Handle exceptions here
  //   }
  // }

  // void getShowBankInvoiceApi2(String _invoiceId) async {
  //   try {
  //     final bodyy = {
  //       'invoice_id': _invoiceId,
  //     };
  //
  //     final res = await http.post(
  //       Uri.parse("${AuthApi.getInvoiceByIdApi}"),
  //       headers: {
  //         'Authorization': 'Bearer $token', // Use the retrieved token
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(bodyy),
  //     );
  //
  //     print('Response Status Code: ${res.statusCode}');
  //     print('Response Body: ${res.body}');
  //
  //     if (res.statusCode == 200) {
  //       Get.back();
  //       if (res.body.isNotEmpty) {
  //         final mydata = jsonDecode(res.body);
  //         // print('Parsed Data: $mydata');
  //         invoiceByIdList.add(GetInvoiceByIdModel.fromJson(mydata));
  //         Get.dialog(IncomingPaymentMethodDialog(
  //           icon: MyImgs.dialogIcon,
  //           text: mydata["message"],
  //           invoiceByIdList: invoiceByIdList,
  //         ));
  //
  //         //
  //         // setState(() {
  //         //   boolData = true;
  //         // });
  //       } else {
  //         Get.back();
  //         print('Error: Empty response');
  //         // Handle empty response here
  //       }
  //     } else {
  //       Get.back();
  //       print('Error: ${res.statusCode}');
  //       // Handle other HTTP status codes here
  //     }
  //   } catch (e) {
  //     Get.back();
  //     print('Error: $e');
  //     // Handle exceptions here
  //   }
  // }
}
