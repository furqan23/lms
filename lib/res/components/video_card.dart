import 'package:flutter/material.dart';
import 'package:splashapp/res/components/mybutton_widget.dart';
import 'package:splashapp/values/auth_api.dart';
import '../color/appcolor.dart';

class VideoCard extends StatefulWidget {
  String? id;
  String title;

  VideoCard({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<VideoCard> createState() => _DashbaordCardState();
}

class _DashbaordCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .27,
          decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.green.shade500,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: MediaQuery.of(context).size.height * .2,
                      decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.network(
                          AuthApi.imageUrl,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Text(
                                "Title : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
                          height: 50,
                          child: const MyButtonWidget(btntitle: "Play Video >"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
