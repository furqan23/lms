import 'package:flutter/material.dart';

import '../values/colors.dart';
class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String titleText;
  final Color color;
  final VoidCallback onTap;

  const CustomListTile({
    this.color = Colors.white,
    required this.leadingIcon,
    required this.titleText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Card(
          elevation: 1,
          child: ListTile(
            leading:Container(
              width: 40,
              height: 30,
             decoration: BoxDecoration(
               shape: BoxShape.circle ,
               color: color,
             ),
              child:  Icon(leadingIcon,color: Colors.white,),
            ),
            title: Text(
              titleText,
              style: const TextStyle(
                fontFamily: 'BandaBold',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,size: 16,color: AppColors.lightColor,),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
