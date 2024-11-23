import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/colors.dart';

import '../values/myimage.dart';

class DashboardCard extends StatefulWidget {
  String? id, catName, description, slug, seat, name, registermethod, image;

  DashboardCard({
    super.key,
    required this.id,
    required this.catName,
    required this.image,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: widget.image == null || widget.image == "null"
                  ? Image(
                      image: AssetImage(tOnBoardingImage3),
                      width: 45,
                      height: 45,
                    )
                  : SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.network(
                        "${AuthApi.dashboardImagesBaseUrl}/${widget.image}",
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: const Icon(
                              Icons.error_outline,
                              size: 45,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            Text(
              widget.catName.toString(),
              style: TextStyle(
                fontSize: 17,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
