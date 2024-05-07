import 'package:flutter/material.dart';

import '../color/appcolor.dart';

class MyButtonWidget extends StatelessWidget {
  final VoidCallback? onpressed;
  final bool isLoading;
  final String btntitle;
  const MyButtonWidget({
    Key? key,
    required this.btntitle,
    this.onpressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading || onpressed == null ? null : onpressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor,
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
            btntitle,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
