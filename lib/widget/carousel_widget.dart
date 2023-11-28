import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final String title;
  final String image;
  final String btntitle;
  final Color color;

  const CarouselWidget({
    super.key,
    required this.title,
    required this.image,
    required this.btntitle,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(

        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child:
            Container(
              padding: const EdgeInsets.fromLTRB(2,2,2,2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: 130,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       color: Colors.yellow,
                  //       borderRadius: BorderRadius.circular(15)),
                  //   child: Text(btntitle),
                  // )
                  SizedBox(
                  child: Image.network(
                    image,
                    // width: 100,
                      height: 130,
                  ),),
                ],
              ),
            ),

        ),

    );
  }
}
