import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:splashapp/values/colors.dart';

class NormalFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, labelText;
  int? maxLengthh;// Change the type to String for asset path
  final TextInputType textInputType;


NormalFiled(
      {super.key,
        required this.controller,
        required this.hintText,
        required this.labelText,

         this.maxLengthh,
        required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          // 4.heightBox,
          TextFormField(maxLength: maxLengthh,
            controller: controller, textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(

                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(

                  width: 2.0,
                ),
              ),

              contentPadding: const EdgeInsets.all(12),

              // prefixIcon: Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Image.asset(
              //     icon1,
              //     width: 20,
              //     color: Colors.grey,
              //   ),
              // ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
            keyboardType: textInputType,

          ),
        ],
      ),
    );
  }
}

