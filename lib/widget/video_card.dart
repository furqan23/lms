import 'package:flutter/material.dart';
import 'package:splashapp/values/colors.dart';

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
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.green.shade500,
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                    color: AppColors.lightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // SizedBox(
                      //     height: MediaQuery.of(context).size.height * 0.05),
                      // Center(
                      //     child: Text(
                      //   widget.slug.toString(),
                      //   style: const TextStyle(
                      //       color: Colors.black, fontWeight: FontWeight.w700),
                      // )),
                      // Align(
                      //     alignment: Alignment.topCenter,
                      //     child: Text(widget.catName.toString(),
                      //         style: const TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w700))),

                      Center(
                        child: Image.network(
                          "https://dav.binshaharts.com/frontend/img/learning.png",
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            // Returning a local image if the network image fails to load
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/logo.png', // Replace 'local_image.png' with your local image asset path
                                width: 100, // Adjust width and height as needed
                                height: 100,
                                fit: BoxFit.contain, // Adjust the fit property as per your requirement
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          const Text(
                            "Title : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),
                    Text(widget.videotitle!,
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 8),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "Video Type: ",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //       Text(
                    //         "",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8),
                    //   child: Row(
                    //     children: [
                    //       const Text(
                    //         "Duration: ",
                    //         style: TextStyle(color: Colors.grey, fontSize: 14),
                    //       ),
                    //       Text(
                    //         widget.slug!,
                    //         style: const TextStyle(fontWeight: FontWeight.bold),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10),
                    //   child: Row(
                    //     children: [
                    //       const Text(
                    //         "Registration Method:   ",
                    //         style: TextStyle(color: Colors.grey, fontSize: 14),
                    //       ),
                    //       Text(
                    //         widget.registermethod!,
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // const Text(
                          //   "Total Seat:  ",
                          //   style: TextStyle(color: Colors.grey, fontSize: 14),
                          // ),
                          // Text(
                          //   widget.seat!,
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          const SizedBox(width: 20),
                          SizedBox(height: MediaQuery.of(context).size.height*.1),
                          Container(
                            alignment: Alignment.center,
                            width: 140,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.primaryColor,
                            ),
                            child: const Text(
                              'Play Video >',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
