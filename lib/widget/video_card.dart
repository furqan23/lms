import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/widget/mybutton_widget.dart';

class VideoCard extends StatefulWidget {
  String? id,
      catName,
      description,
      slug,
      seat,
      name,
      registermethod,
      videotitle;

  VideoCard({
    super.key,
    required this.id,
    required this.videotitle,
    required this.name,
    required this.description,
    required this.catName,
    required this.slug,
    required this.seat,
    required this.registermethod,
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
          height:  MediaQuery.of(context).size.height*.28,
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
                      height: MediaQuery.of(context).size.height*.2,
                      decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.network(
                          AuthApi.imageUrl,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 100,
                                height: 100,
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
                          width: 200,
                          child: Text(widget.videotitle!,
                          ),
                        ),


                        SizedBox(height: MediaQuery.of(context).size.height*.04),

                        const MyButtonWidget(btntitle: "Play Video >"),
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
