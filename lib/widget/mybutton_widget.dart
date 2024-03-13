import 'package:flutter/material.dart';

import '../values/colors.dart';

class MyButtonWidget extends StatelessWidget {
  final String btntitle;
  const MyButtonWidget({super.key, required this.btntitle});

  @override
  Widget build(BuildContext context) {
    return     Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width*.40,
      height: MediaQuery.of(context).size.height*.044,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.primaryColor,
      ),
      child:  Text(
        btntitle,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
