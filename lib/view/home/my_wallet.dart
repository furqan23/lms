import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/cart_controller.dart';
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/cart_model.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/my_imgs.dart';
import 'package:splashapp/values/text_string.dart';
import 'package:splashapp/widget/incoming_payment_method_dialog.dart';
import 'package:splashapp/widget/show_load_indicator.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWallletState();
}

class _MyWallletState extends State<MyWallet> {

  String walletBalanceStr="";
  String? tokenn;
  List<CartModel> cartList = [];
  List<InvoiceModel> invoiceList = [];
  List<GetInvoiceByIdModel> invoiceByIdList = [];
  String course = 'course';
  String test = 'test'; // test
  bool boolData = false;
  String? token;




  final CartController _cartController = Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenFromHive();
  }





  void getInvoiceID2() async {
    showLoadingIndicator(context);
    try {
      List<Map<String, dynamic>> requestDataList = [];

      for (int i = 0; i < cartList.length; i++) {
        Map<String, dynamic> cartData = {
          "course_id": cartList[i].courseId,
          "group_id": cartList[i].groupId,
          "category_id": cartList[i].categoryid,
          'fee_type': test,
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
          getShowBankInvoiceApi2(
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



  void getShowBankInvoiceApi2(String _invoiceId) async {
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
            icon: MyImgs.dialogIcon,
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


  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    // print('Token: $token');
    // getInvoiceID();
    getInvoiceID2();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wallet"),
      ),


        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 40,
              left: 300,
              child: FloatingActionButton(
                onPressed: () {
                  int tempQuantity = _cartController
                      .quantity.value; // Create a temporary variable
                  double tempTotalBalance =
                      _cartController.totalBalance.value * _cartController.quantity.value;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // title: const Text('Your Dialog Title'),
                        content: SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Obx(() => Text(
                                    'Total Amount: ${currency}: ${_cartController.totalBalance.value.toStringAsFixed(0)}',
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
                                          _cartController.decrementQuantity();
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
                                      Obx(() => Text(_cartController.quantity.value
                                          .toString())), // Display the quantity from the controller
                                      InkWell(
                                        onTap: () {
                                          _cartController.incrementQuantity();
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
                                  ),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      getTokenAndFetchInvoice();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 90,
                                      height: 40,
                                      decoration:  BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Text("create"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.blue, // Replace with your desired color
              ),
            ),
          ],
        ),



      body: Column(
        children: [
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Balance of test in the wallet. You can use this balance to get online test",style: TextStyle(fontSize: 24),),
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(width:MediaQuery.of(context).size.width,child: Card(elevation:1,child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("Current Balance $currency $walletBalanceStr",style: TextStyle(color: Colors.green,fontSize: 20),),
          ))),
        ],
      ),
    );
  }


  Future<String?> getTokenFromHive() async {
    final box = await Hive.openBox<String>('tokenBox');
     box.get('token');
     tokenn=box.get('token');
     getWalletApi();
     return "ok";
  }


  void getWalletApi() async {
    try {
      final res = await http.get(
        Uri.parse(AuthApi.getMyWalletApi), headers: {
          'Authorization': 'Bearer $tokenn', // Use the retrieved token
          'Content-Type': 'application/json',
        },
      );
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // courseList.add(CourseModel.fromJson(mydata));
          walletBalanceStr=mydata['data']["balance"].toString();
          setState(() {
            // boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }






}
