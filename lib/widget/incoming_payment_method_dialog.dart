import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/model/get_invoice_id_model.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/view/cart/confirmation_mesg.dart';

import 'custom_button.dart';

class IncomingPaymentMethodDialog extends StatefulWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final String? invoiceId;
  final String? status;
  List<GetInvoiceByIdModel> invoiceByIdList = [];

  IncomingPaymentMethodDialog({
    super.key,
    this.text,
    this.color,
    this.textColor,
    this.invoiceId,
    this.status,
    required this.invoiceByIdList,
  });

  @override
  State<IncomingPaymentMethodDialog> createState() => _IncomingJobState();
}

class _IncomingJobState extends State<IncomingPaymentMethodDialog> {


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    List<Widget> customButtons = [];

    for (int i = 0; i < 3; i++) {
      if (widget.invoiceByIdList.isNotEmpty &&
          widget.invoiceByIdList[0].data?.pMethods != null &&
          widget.invoiceByIdList[0].data!.pMethods!.length > i) {
        final paymentMethod =
        widget.invoiceByIdList[0].data!.pMethods![i];
        log("Payment Method $i: ${paymentMethod.toString()}");
        customButtons.add(
          CustomButton(
            title: "${paymentMethod.paymentTitle}",
            colorOne: AppColors.tbtn1,
            colorTwo: AppColors.tbtn2,
            onPressed: () {
              Get.to(() => ConfirmationMesg(
                data: paymentMethod.description ?? "na",
              ));
            },
          ),
        );
      }
    }
    return Dialog(
      child: Container(
          padding: const EdgeInsets.all(20),
          height: mediaQuery.height * 0.60,
          width: mediaQuery.width * 0.85,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "invoice Id ${widget.invoiceByIdList[0].data?.inv!.invoiceDetil?[0].invoiceId}",
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w100),
                ),
                Text(
                  "Price ${widget.invoiceByIdList[0].data?.inv!.invoiceDetil?[0].price}",
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w100),
                ),


                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Payment Methods",
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w100),
                ),
                const SizedBox(
                  height: 30,
                ),

                Column(
                  children: customButtons,
                ),
              ],
            ),
          )),
    );
  }
}
