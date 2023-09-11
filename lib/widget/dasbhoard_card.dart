import 'package:flutter/material.dart';
import 'package:splashapp/values/colors.dart';

import '../values/myimage.dart';

class DashbaordCard extends StatefulWidget {
  String? id, catName, description, slug, seat, name, registermethod;

  DashbaordCard({
    super.key,
    required this.id,
    required this.catName,
  });

  @override
  State<DashbaordCard> createState() => _DashbaordCardState();
}

class _DashbaordCardState extends State<DashbaordCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Column(
          children: [
            Center(
              child: Image(
                image: AssetImage(tOnBoardingImage3),
                width: 100,
                height: 100,
              ),
            ),
            Text(widget.catName.toString(),style: TextStyle(
              fontSize: 22,
            ),),
          ],
        ),
      ),
    );
  }
}
