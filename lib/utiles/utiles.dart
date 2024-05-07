
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utiles {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).nextFocus();
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.black26);
  }

  static snakBar(String title, String message) {
    Get.snackbar(title, message);
  }


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regular expression for email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }


 String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  // Check for minimum length
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  // Add more conditions as needed, such as checking for uppercase, lowercase, digits, etc.
  // For example:
  // if (!value.contains(RegExp(r'[A-Z]'))) {
  //   return 'Password must contain at least one uppercase letter';
  // }
  // if (!value.contains(RegExp(r'[a-z]'))) {
  //   return 'Password must contain at least one lowercase letter';
  // }
  // if (!value.contains(RegExp(r'[0-9]'))) {
  //   return 'Password must contain at least one digit';
  // }
  // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
  //   return 'Password must contain at least one special character';
  // }

  return null;
}


String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  // You can add additional validation rules here if needed
  // For example, you might want to check if the name contains only alphabetic characters
  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
    return 'Please enter a valid name';
 }
  return null;
}

}
