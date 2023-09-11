

import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? showSuffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    this.obscureText,
    this.textInputAction,
    this.keyboardType,
    this.label,
    this.showSuffixIcon,
    required this.controller,
    required this.validator,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool showVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20,),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(9),
          suffixIcon: widget.showSuffixIcon! == true
              ? IconButton(
            icon: Icon(
              showVisibility ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                showVisibility = !showVisibility;
              });
            },
          )
              : null,
          border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          labelText: widget.label ?? '',

        ),
        obscureText: widget.obscureText! == true ? !showVisibility : false,
        keyboardType: widget.keyboardType!,
        textInputAction: widget.textInputAction!,
        validator: widget.validator,

      ),


    );
  }
}

