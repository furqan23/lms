import 'package:flutter/material.dart';

class VideoCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String subtitle3;


  const VideoCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle3,


  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Stack(
        children: [
          Positioned(
            top: 25,
            left: 20,
            child: Material(
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(-10.0, 10.0),
                        blurRadius: 20,
                        spreadRadius: 4.0,
                      )
                    ]),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 25,
            child: Card(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: 120,
                height: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/$image'))),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 170,
            child: Container(
              height: 150,
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "Name ${title}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF363f93),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [

                      Text(
                        "Name: ${subtitle1}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Seats: ${subtitle2}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [

                      Text(
                        "price ${subtitle3}",
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Positioned(
              top: 160,
              left: 240,
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Read',
                  style: TextStyle(color: Colors.blue),
                ),
              ))
        ],
      ),
    );
  }
}
