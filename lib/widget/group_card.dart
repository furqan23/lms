import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/colors.dart';

class GroupsCard extends StatefulWidget {
  String id;
  String groupCode;
  String name;
  String registrationMethod;
  String catName;
  String buttonText;

  GroupsCard({
    super.key,
    required this.id,
    required this.name,
    required this.catName,
    required this.groupCode,
    required this.registrationMethod,
    required this.buttonText,
  });

  @override
  State<GroupsCard> createState() => _DashbaordCardState();
}

class _DashbaordCardState extends State<GroupsCard> {
  @override
  Widget build(BuildContext context) {
    int maxChars = MediaQuery.of(context).size.width ~/ 20;
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
      child: Card(
        elevation: 3,
        child: Container(
          width: double.infinity,
          height: 160,
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
                  height: 116,
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
                          AuthApi.imageUrl,
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
                                    .fitHeight, // Adjust the fit property as per your requirement
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
                      widget.id.length > maxChars
                          ? "${widget.id.substring(0, maxChars)}..."
                          : widget
                              .id, // Truncate text to 10 characters if necessary
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow:
                          TextOverflow.ellipsis, // Ensures "..." for overflow
                      maxLines: 1, // Restricts text to one line
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            "${widget.catName!}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text(
                          //   widget.name!,
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: [
                          const Text(
                            "",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            "",
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
