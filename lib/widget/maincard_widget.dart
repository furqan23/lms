import 'package:flutter/material.dart';

class MainCardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;

  const MainCardWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 1,
              )
            ]),
        child: Text(title),
      ),
    );
  }
}
