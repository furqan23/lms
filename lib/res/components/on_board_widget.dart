

import 'package:flutter/material.dart';

import '../../model/onboard_model.dart';



class OnBoardWidget extends StatelessWidget {
final OnBoardModel model;
  const OnBoardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return  Container(
                color: model.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage(model.image),
                      height:model.height *0.4,
                    ),
                    Column(
                      children: [
                        Text(model.title),
                        Text(model.subTile,textAlign: TextAlign.center,),
                      ],
                    ),
                    Text(model.couterText),
                    SizedBox(height: 50.0,), 
                  ],
                ),
              );
  }
}