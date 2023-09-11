import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height /1.5,
            decoration: BoxDecoration(

            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Color(0xffBDC3C7),
                  child: const Stack(
                    children: [
                      Positioned(
                        left: 100,
                        top: 40,
                        child: Text(
                          'ETEA',
                          style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 170,
                        top: 50,
                        child: Text(
                          'Group A',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: const Color(0xffF7F8F3),
                  child: const Stack(
                    children: [
                      Positioned(
                        left: 100,
                        top: 40,
                        child: Text(
                          'Rs 650',
                          style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 185,
                        top: 50,
                        child: Text(
                          '/ whole Course',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.only(left: 10,top: 10),
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '1. ',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              'english',
                              style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'By : ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Gabriel Gestosani',
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.only(left: 10,top: 10),
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '1. ',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              'english',
                              style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'By : ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Gabriel Gestosani',
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                    
                  ),
                  child: Text('Add To Cart',style: TextStyle(color: Colors.green),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
