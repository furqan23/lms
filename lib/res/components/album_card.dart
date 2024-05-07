import 'package:flutter/material.dart';
import 'mybutton_widget.dart';


class AlbumCard extends StatefulWidget {
  String? id, albam_code, albam_title;

  AlbumCard({
    super.key,
    required this.id,
    required this.albam_code,
    required this.albam_title,


  });

  @override
  State<AlbumCard> createState() => _DashbaordCardState();
}

class _DashbaordCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Card(
        elevation: 5,
        child:
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height* 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white12,
              border: Border.all(
                color: Colors.green.shade500,

              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.01),
                MyTextWidget(title: "Code:", subtitle:widget.albam_code!),

                MyTextWidget(title: "Title:", subtitle: widget.albam_title!),

                SizedBox(height: MediaQuery.of(context).size.height*.02),
             const MyButtonWidget(btntitle: "Video lectures"),

              ],
            ),
          ),


        ),
      )
    );
  }
}



class MyTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const MyTextWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w400,color:Colors.grey),
        ),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width:256,
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w900),
            ),
          ),
        )
      ],
    );
  }
}
