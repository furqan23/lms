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
        height: 180,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(btntitle),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 60,
                left: 164,
                child: Image.asset(
                  image,
                  width: 100,
                  height: 100,
                ))
          ],
        ),
      ),
    );
  }
}
