import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;
  const FormHeaderWidget({
    super.key,
    this.imageColor,
     this.imageHeight =0.2,
    this.heightBetween,
    this.textAlign,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Column(
      crossAxisAlignment:crossAxisAlignment,
      children: [
       Image(image: AssetImage(image),color: imageColor, height: size.height * imageHeight, ),
        SizedBox(height: heightBetween),
     //   Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
        Text(subtitle,textAlign: textAlign, style: TextStyle(fontSize: 18),),


      ],
    );
  }
}
