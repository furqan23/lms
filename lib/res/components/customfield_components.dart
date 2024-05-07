import 'package:flutter/material.dart';

class CustomFieldComponets extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final VoidCallback? onpressed;
  final IconData? suffixIcon;
  final bool obscureText; // New parameter to control obscureText

  const CustomFieldComponets({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.onpressed,
  }) : super(key: key);

  @override
  _CustomFieldComponetsState createState() => _CustomFieldComponetsState();
}

class _CustomFieldComponetsState extends State<CustomFieldComponets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
            onPressed: widget.onpressed,
            icon: Icon(widget.suffixIcon),
          )
              : null,
          contentPadding: const EdgeInsets.all(9),
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
        ),
        validator: widget.validator,
      ),
    );
  }
}