import 'package:flutter/material.dart';




class ButtonWidget extends StatefulWidget {
  final String? text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const ButtonWidget({
    super.key,
    this.text,
    this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 50,
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.redAccent,
     //   gradient: LinearGradient(colors: [kbuttonGradient1, kbuttonGradient2]),
        borderRadius:   BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: widget.foregroundColor ?? Colors.white,
          // backgroundColor: widget.backgroundColor ?? Colors.blue,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
        ),
        child: Text(
          widget.text! == "" ? "Button" : widget.text!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
