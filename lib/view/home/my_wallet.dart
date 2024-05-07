import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashapp/model/cart_model.dart';
import 'package:splashapp/model/createinvoice_model.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/model/testfee_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/constants/constants.dart';
import 'package:splashapp/res/stringstext/text_string.dart';
import 'package:splashapp/view_model/Controller/cart_controller.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import 'package:splashapp/widget/incoming_payment_method_dialog.dart';
import 'package:splashapp/widget/show_load_indicator.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWallletState();
}

class _MyWallletState extends State<MyWallet> {
  String walletBalanceStr = "";
  CartController? cartController;
  bool isLoading = true;
  int testfee = 0;
  String? tokenn;
  List<CartModel> cartList = [];
  List<InvoiceModel> invoiceList = [];
  List<TestFee> testfeeList = [];
  List<GetInvoiceByIdModel> invoiceByIdList = [];
  String course = 'course';
  String _test = 'test'; // test
  bool boolData = false;
  String? token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenFromHive();
    log('befre passing test feee $testfee');
    cartController = Get.find<CartController>();
    getCartData();
  }

  Future<void> getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartData');

    if (cartData != null && cartData.isNotEmpty) {
      Iterable decoded = json.decode(cartData);
      List<CartModel> cartItems = decoded.map((item) => CartModel.fromJson(item)).toList();

      setState(() {
        cartList = cartItems;
      });
      print('Fetched Cart Data: $cartList');
    }

  }
  void getInvoiceID2() async {
    showLoadingIndicator(context);
    try {
      List<Map<String, dynamic>> requestDataList = [];


      // log("cartlenht: $cartList.length.toString()");
      for (int i = 0; i < 1; i++) {

        Map<String, dynamic> cartData = {
          'fee_type': _test,
          "qty": cartController!.quantity.value.toString(),
        };
        requestDataList.add(cartData);

        print(requestDataList);
      }

      // final String requestBody = jsonEncode(requestDataList);

      // List<Map<String, dynamic>> requestDataBody;
      Map<String, dynamic> requestDataBodyy = {
        "bodyy": requestDataList,
      };

      print("request body new $requestDataBodyy");
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
            invoiceId: mydata['id'],
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
        title: const Text("My Wallet"),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 300,
            child: FloatingActionButton(
              onPressed: () {
                // int tempQuantity = cartController
                // !.quantity.value; // Create a temporary variable
                // double tempTotalBalance = cartController!.totalBalance.value *
                //     cartController!.quantity.value;
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
                                 Text(
                                  'Per Test Fee: $currency $testfee',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 13,),
                                const Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(
                                      () => Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                    ' ${currency} ${cartController!.totalBalance.value}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                      ),
                                ),

                                // Text( 'Total Amount: ${currency}${_cartController.totalBalance.value.toStringAsFixed(0)}'),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cartController!
                                            .decrementQuantity(testfee);
                                        cartController!.update();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor,
                                        ),
                                        child: const Icon(Icons.remove,color: AppColors.whiteColor),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(cartController!.quantity.value.toString()),
                                    ), // Display the quantity from the controller
                                    InkWell(
                                      onTap: () {
                                        cartController!
                                            .incrementQuantity(testfee);
                                        cartController!.update();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor,
                                        ),
                                        child: const Icon(Icons.add,color: AppColors.whiteColor,),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                    getTokenAndFetchInvoice();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text("create",style: textwhiteColorStyle,),
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
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add),
              // Replace with your desired color
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Card(
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "You can use this balance to get online test",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(), // Show loading indicator while data is being fetched
          )
              : SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Current Balance $currency ${walletBalanceStr.isEmpty ? 'Loading...' : walletBalanceStr}",
                  style: const TextStyle(color: Colors.green, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> getTokenFromHive() async {
    final box = await Hive.openBox<String>('tokenBox');
    box.get('token');
    tokenn = box.get('token');
    getWalletApi();
    getTestFee();
    return "ok";
  }

  void getWalletApi() async {

    try {
      final res = await http.get(
        Uri.parse(AuthApi.getMyWalletApi),
        headers: {
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
          walletBalanceStr = mydata['data']["balance"].toString();
          setState(() {
            isLoading = false; // Set isLoading to false when data is loaded
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

  void getTestFee() async {
    try {
      final res = await http.post(
        Uri.parse(AuthApi.getTestfee),
        headers: {
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
          testfee = mydata['data']["test_fee"];
          cartController!.totalBalance.value = testfee * cartController!.quantity.value;
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
