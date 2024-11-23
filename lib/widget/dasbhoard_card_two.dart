import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/colors.dart';

class DashbaordCardTwo extends StatefulWidget {
  String? id,
      courseImage,
      catName,
      description,
      slug,
      seat,
      name,
      registermethod,
      buttonText,
      group;

  DashbaordCardTwo({
    super.key,
    required this.id,
    required this.courseImage,
    required this.name,
    required this.description,
    required this.catName,
    required this.slug,
    required this.seat,
    required this.registermethod,
    required this.group,
    required this.buttonText,
  });

  @override
  State<DashbaordCardTwo> createState() => _DashbaordCardState();
}

class _DashbaordCardState extends State<DashbaordCardTwo> {
  @override
  Widget build(BuildContext context) {
    print(widget.courseImage);
    print(widget.courseImage is String);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
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
                padding: const EdgeInsets.only(top: 5),
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
                          "${AuthApi.imagesBaseUrl}/course/${widget.courseImage}",
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            // Returning a local image if the network image fails to load
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/logo.png', // Replace 'local_image.png' with your local image asset path
                                width: 100, // Adjust width and height as needed
                                height: 100,
                                fit: BoxFit
                                    .contain, // Adjust the fit property as per your requirement
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.group!}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              "${widget.catName!}/${widget.slug}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Text(
                          //   widget.name!,
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Lecturer: ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            widget.name!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
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
                          Container(
                            alignment: Alignment.center,
                            width: 140,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.primaryColor,
                            ),
                            child: Text(
                              widget.buttonText!,
                              style: const TextStyle(
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
