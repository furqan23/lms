// ignore_for_file: non_constant_identifier_names


import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:splashapp/values/colors.dart';

Widget CustomButton({
  required String title,
  required VoidCallback onPressed,
  required Color colorOne,
  required Color colorTwo,

}) {
  return SizedBox(
    width: double.infinity,
    height: 58,
    child: Padding(
      padding: EdgeInsets.fromLTRB(4,0,4,8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: colorOne.withOpacity(0.3),
            blurRadius: 2,
            offset: Offset(2, 3), // Shadow position
          ),
        ],
          borderRadius: BorderRadius.circular(15),
          gradient:  LinearGradient(
            colors: [
              colorOne,
              colorTwo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),// <-- Radius
          ),
        ),
          onPressed: () { onPressed(); },
          child: Text(
            title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.whiteColor),
          ),
        ),
      ),
    ),
  );
}
