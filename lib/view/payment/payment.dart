import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splashapp/res/assets/images_assets.dart';
import 'package:splashapp/values/auth_api.dart';

import 'package:splashapp/view/payment/Invoice_payment.dart';
import 'package:splashapp/widget/customcard_widget2.dart';
import 'package:splashapp/widget/show_load_indicator.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import '../../model/invoice_model.dart' as data;
import '../../model/payment_model.dart';
import '../../model/get_invoice_id_model.dart' as getinvoice;
import '../../res/logs/logs.dart';
import '../../widget/incoming_payment_method_dialog.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<Data> paymentList = [];
  bool boolData = false;

  List<getinvoice.GetInvoiceByIdModel> invoiceByIdList = [];
  String? token;
  bool isLoading = true;
  data.InvoiceModel? invoiceData;

  @override
  void initState() {
    // TODO: implement initState
    getPaymentAPI();
    // getTokenAndFetchInvoice();
    super.initState();
  }

  void getPaymentAPI() async {
    setState(() {
      boolData = true;
    });
    final String? token = await LoginController().getTokenFromHive();
    print('Token: $token');

    try {
      final res = await http.get(
        Uri.parse(
          AuthApi.getPayApi,
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        print('this is asim khan');
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          setState(() {
            boolData = false;
            print(boolData.toString());
            final d = PaymentModel.fromJson(mydata);
            paymentList = d.data!;
          });
        } else {
          setState(() {
            boolData = false;
          });
          throw Exception('Empty response');
        }
      } else {
        setState(() {
          boolData = false;
        });
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      setState(() {
        boolData = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Payments"),
        ),
        body: boolData == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : paymentList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          MyImgs.payment,
                          width: 60,
                          height: 70,
                        ),
                        Text("No Payment Required"),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: paymentList.length ?? 0,
                    itemBuilder: (context, index) {
                      String? createDateStr = paymentList[index].createdAt;
                      DateTime createDate =
                          DateTime.tryParse(createDateStr!) ?? DateTime.now();

                      // Format the date to show only the date portion
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(createDate);
                      // Calculate the total price by summing up all prices in invoiceDetil
                      double totalAmount = 0.0;
                      for (var invoice in paymentList[index].invoiceDetil!) {
                        totalAmount +=
                            double.tryParse(invoice.price.toString()) ?? 0.0;
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomCardWidget2(
                              onClcik: (){
                                print("click for dialog");
                                getShowBankInvoiceApi(
                                    paymentList[index].id.toString());
                              },
                              // onPressed: () {
                              //   Get.to(
                              //     () => InvoicePayment(
                              //       ref_id: paymentList[index].refId.toString(),
                              //       invoice_id:
                              //           paymentList[index].id.toString(),
                              //     ),
                              //   );
                              // },
                              title: '${index + 1}',
                              inv: paymentList[index].id.toString(),
                              refid: paymentList[index]
                                  .refId
                                  .toString(), // Display the formatted date as the invoice
                              Amount: totalAmount.toStringAsFixed(
                                  2), // Display the total amount
                              createDate:
                                  formattedDate, // Display the formatted date
                              Status: paymentList[index].status.toString(),
                              Attachment: 'Show',
                            ),
                          ),

                        ],
                      );
                    },
                  ));
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getInvoiceAPI(paymentList[0].id.toString());
    getShowBankInvoiceApi(paymentList[0].id.toString());
  }

  void getInvoiceAPI(String invoiceId) async {
    try {
      final Map<String, dynamic> requestData = {
        "invoice_id": invoiceId,
      };

      final String requestBody = jsonEncode(requestData);
      print("Khushal khan: $requestData");

      final res = await http.post(
        Uri.parse(AuthApi.postInvoiceById),
        body: requestBody,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response khan Status Code: ${res.statusCode}');
      print('Response khsuhal Body long');
      LogPrint(res.body.toString());

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(res.body);
        setState(() {
          isLoading = false; // Update loading state
          invoiceData = data.InvoiceModel.fromJson(responseData);
        });
        print('Received Data: $responseData');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getShowBankInvoiceApi(String _invoiceId) async {

    showLoadingIndicator(context);
      token = await LoginController().getTokenFromHive();
      print('Token dialog api: $token');


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
      //  Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // print('Parsed Data: $mydata');
          invoiceByIdList.add(getinvoice.GetInvoiceByIdModel.fromJson(mydata));
          Get.back();
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
