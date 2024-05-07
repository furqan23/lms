import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import '../color/appcolor.dart';

class DashbaordCardTwo extends StatefulWidget {
  String? id,
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
                      Center(
                        child: Image.network(
                          AuthApi.imageUrl,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
