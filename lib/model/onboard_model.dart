import 'package:flutter/material.dart';

class OnBoardModel{
  final String image;
  final String title;
  final String subTile; 
  final String couterText; 
  final Color color; 
  final double height;

  OnBoardModel({
    required this.image, 
    required this.title, 
    required this.subTile, 
    required this.couterText, 
    required this.color, 
    required this.height,
  });
}