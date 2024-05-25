import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/stringstext/text_string.dart';
import 'package:splashapp/view/home_detail/home_detail.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import 'package:splashapp/widget/incoming_payment_method_dialog.dart';
import 'package:splashapp/widget/show_load_indicator.dart';
import '../../model/cart_model.dart';
import '../../values/auth_api.dart';

class CartScreen extends StatefulWidget {
  final List<CartModel> cartList;

  const CartScreen({super.key, required this.cartList});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartModel> cartList = [];
  List<InvoiceModel> invoiceList = [];
  List<GetInvoiceByIdModel> invoiceByIdList = [];
  String course = 'course';
  String test = 'test'; // test
  bool boolData = false;
  String? token;

  @override
  void initState() {
    super.initState();
    getCartData();
  }

  Future<void> getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartDataString = prefs.getString('cartData');

    setState(() {
      if (cartDataString != null) {
        List<dynamic> decodedList = json.decode(cartDataString);
        cartList = decodedList.map((item) => CartModel.fromJson(item)).toList();
      } else {
        // If no data found in SharedPreferences, use the data from the widget
        cartList = widget.cartList;
      }
    });
  }

  Future<void> saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = widget.cartList.map((cart) => cart.toJson()).toList();
    await prefs.setString('cartData', json.encode(cartData));
    print(cartData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: widget.cartList.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cartList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Group Name: ${cartItem.groupname}'),
                        Text("Category Name: ${cartItem.categoryname}"),
                        Text("Course title: ${cartItem.courseTitle}"),
                        Text('Price: ${cartItem.price.toStringAsFixed(2)}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (cartItem.registrationMethod == 'single') {
                                    widget.cartList
                                        .removeAt(index); // Remove single item
                                  } else if (cartItem.registrationMethod ==
                                      'whole') {
                                    widget.cartList.removeWhere((item) =>
                                        item.registrationMethod ==
                                        'whole');
                                  }
                                });
                                saveCartData(); // Save the updated cart data
                              },
                              icon: cartItem.registrationMethod == 'single'
                                  ? const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )
                                  : cartItem.registrationMethod == 'whole' &&
                                          index ==
                                              widget.cartList
                                                      .where((item) =>
                                                          item.registrationMethod ==
                                                          'whole')
                                                      .length -
                                                  1
                                      ? InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.green,
                                          ),
                                        )
                                      : SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                if (index % 4 == 3 &&
                    widget.cartList[index].registrationMethod == "whole") {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 5,
                  ); // Show divider for whole items
                }
                return const SizedBox.shrink(); // No divider for other items
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              'Total Price: $currency ${widget.cartList.fold<double>(0, (total, item) => total + item.price)}',
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
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
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

      for (int i = 0; i < cartList.length; i++) {
        Map<String, dynamic> cartData = {
          "course_id": cartList[i].courseId,
          "group_id": cartList[i].groupId,
          "category_id": cartList[i].categoryid,
          'fee_type': course,
          "qty": cartList.length,
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
              invoiceList[0].data!.invoiceId.toString() ?? "na");
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
}
