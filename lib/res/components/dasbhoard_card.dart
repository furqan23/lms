import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import '../assetsimages/myimage.dart';

class DashbaordCard extends StatefulWidget {
  String? id, catName, description, slug, seat, name, registermethod,image;

  DashbaordCard({
    super.key,
    required this.id,
    required this.catName,
    required this.image,
  });

  @override
  State<DashbaordCard> createState() => _DashbaordCardState();
}

class _DashbaordCardState extends State<DashbaordCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        child: Column(
          children: [
            Center(
              child:widget.image==null || widget.image=="null"?Image(
          image: AssetImage(tOnBoardingImage3),
          width: 45,
          height: 45,
        ):SizedBox(height:45,width:45,child: Image.network("${AuthApi.dashboardImagesBaseUrl}/${widget.image}"))
            ),
            Text(widget.catName.toString(),style: const TextStyle(
              fontSize: 17,letterSpacing: -1,
            ),),
          ],
        ),
      ),
    );
  }
}
