import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Controller/cart_controller.dart';
import '../../Controller/login_controller.dart';
import '../../model/cart_model.dart';
import '../../model/createinvoice_model.dart';
import '../../model/get_invoice_id_model.dart';
import '../../values/auth_api.dart';
import '../../values/colors.dart';
import '../../values/my_imgs.dart';
import '../../widget/incoming_payment_method_dialog.dart';

class TestPay extends StatefulWidget {
  final List<CartModel> cartList;
  const TestPay({Key? key,required this.cartList}) : super(key: key);

  @override
  State<TestPay> createState() => _TestPayState();
}

class _TestPayState extends State<TestPay> {

  final CartController cartController = Get.put(CartController());
  List<InvoiceModel> invoiceList = [];
  List<GetInvoiceByIdModel> invoiceByIdList = [];
  String test = 'test'; // test
  bool boolData = false;
  String? token;
  List<CartModel> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Pay"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  cartController.decrementQuantity();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
              Obx(() => Text(cartController.quantity.value.toString())),
              InkWell(
                onTap: () {
                  cartController.incrementQuantity();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .06),
          Obx(() => Text(
              "Total Price: \$${cartController.totalBalance.value.toStringAsFixed(2)}")),
          InkWell(
            onTap: () {
              getInvoiceID();
              // getTokenAndFetchInvoice();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
            ),
          ),
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
    //showLoadingIndicator(context);
    try {
      List<Map<String, dynamic>> requestDataList = [];

      for (int i = 0; i < widget.cartList.length; i++) {
        print('Course ID: ${widget.cartList[i].courseId}');
        print('Group ID: ${widget.cartList[i].groupId}');
        print('Category ID: ${widget.cartList[i].categoryid}');
        print('Fee Type: $test');
        print('Quantity: 1');

        Map<String, dynamic> cartData = {
          "course_id": widget.cartList[i].courseId,
          "group_id": widget.cartList[i].groupId,
          "category_id": widget.cartList[i].categoryid,
          'fee_type': test,
          "qty": 1
        };
        requestDataList.add(cartData);
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
          //    getShowBankInvoiceApi(
          //      invoiceList[0].data?.invoiceId.toString() ?? "na");
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
}
