
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/values/colors.dart';


class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double? roundCorner;
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  void Function() onPressed;
  CustomButton({
    required this.height,
    required this.width,
    required this.text,
    this.fontSize,
    this.borderColor,
    this.textColor,
    this.roundCorner,
    this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return MaterialButton(
      color: color == null ? AppColors.primaryColor : color,
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: borderColor == null
                ? AppColors.primaryColor
                : borderColor!),
        borderRadius:
            BorderRadius.circular(roundCorner == null ? 5 : roundCorner!),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color:
                  textColor == null ? AppColors.whiteColor : textColor!,
              fontSize: fontSize == null ? 16 : fontSize,

              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
