import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/payment/Invoice_payment.dart';
import '../../Controller/login_controller.dart';
import '../../model/payment_model.dart';
import '../../widget/customcard_widget.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<PaymentModel> paymentList = [];
  bool boolData = false;

  @override
  void initState() {
    // TODO: implement initState
    getPaymentAPI();
    super.initState();
  }

  void getPaymentAPI() async {
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
          paymentList.add(PaymentModel.fromJson(mydata));
          setState(() {
            boolData = true;
          });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Payments"),),
      body: boolData
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: paymentList[0].data?.length,
              itemBuilder: (context, index) {
                String? createDateStr = paymentList[0].data![index].createdAt;
                DateTime createDate =
                    DateTime.tryParse(createDateStr!) ?? DateTime.now();

                // Format the date to show only the date portion
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(createDate);

                // Calculate the total price by summing up all prices in invoiceDetil
                double totalAmount = 0.0;
                for (var invoice in paymentList[0].data![index].invoiceDetil!) {
                  totalAmount +=
                      double.tryParse(invoice.price.toString()) ?? 0.0;
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: CustomCardWidget(
                      onPressed: (){
                        Get.to(()=>InvoicePayment(invoice_id: paymentList[0].data![index].id.toString()));
                      },
                      title: '1',
                      inv: paymentList[0]
                          .data![index]
                          .id
                          .toString(), // Display the formatted date as the invoice
                      Amount: totalAmount
                          .toStringAsFixed(2), // Display the total amount
                      createDate: formattedDate, // Display the formatted date
                      Status: paymentList[0].data![index].status.toString(),
                      Attachment: 'Show',
                    ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
