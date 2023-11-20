import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ConfirmationMesg extends StatefulWidget {
  final data;

  ConfirmationMesg({super.key, required this.data});

  @override
  State<ConfirmationMesg> createState() => _ConfirmationMesgState();
}

class _ConfirmationMesgState extends State<ConfirmationMesg> {
  @override
  Widget build(BuildContext context) {
    print("${widget.data}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Html(data: widget.data),
      ),
    );
  }
}
