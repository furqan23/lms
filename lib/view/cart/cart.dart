import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/values/text_string.dart';
import 'package:splashapp/view/home_detail/home_detail.dart';
import 'package:splashapp/widget/incoming_payment_method_dialog.dart';
import 'package:splashapp/widget/show_load_indicator.dart';
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

  Map<String, List<CartModel>> groupCartItemsByName() {
    Map<String, List<CartModel>> groupedItems = {};

    for (var item in cartList) {
      if (!groupedItems.containsKey(item.groupname)) {
        groupedItems[item.groupname] = [item];
      } else {
        groupedItems[item.groupname]!.add(item);
      }
    }

    return groupedItems;
  }

  double calculateTotalBalance() {
    return cartList.fold(0.0, (double sum, CartModel cartItem) {
      return sum + cartItem.price;
    });
  }

  void deleteCartItem(int index) {
    setState(() {
      String groupNameToRemove = cartList[index].groupname;
      cartList.removeAt(index);

      // Remove all items with the same category name
      cartList.removeWhere((item) => item.groupname == groupNameToRemove);
      cartInt.value = cartList.length.toString();
      saveCartData();
    });
  }

  Future<void> saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cartData', json.encode(cartList));
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total balance by summing up the prices of all items in the cart

    double totalBalance = calculateTotalBalance();
    Map<String, List<CartModel>> groupedCartItems = groupCartItemsByName();

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
                shrinkWrap: true,
                itemCount: groupedCartItems.length,
                itemBuilder: (context, index) {
                  var groupName = groupedCartItems.keys.toList()[index];
                  print("tettstst ${groupName}");
                  var groupItems = groupedCartItems[groupName]!;

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Group Name: $groupName'),
                          ),
                          Column(
                            children: groupItems.map((item) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    color: AppColors.whiteshade100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Category Name: ${item.categoryname}"),
                                          Text(
                                              "Course title: ${item.courseTitle}"),
                                          Text(
                                              'Price: ${item.price.toStringAsFixed(2)} $currency'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  deleteCartItem(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
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
            padding: const EdgeInsets.all(1.0),
            child: Text(
              'Total Amount: $currency ${totalBalance.toStringAsFixed(2)}',
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
