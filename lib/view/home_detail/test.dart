import 'package:flutter/material.dart';

class TestData extends StatelessWidget {

  const TestData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey)),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/images/1.png"),
                    const Positioned(
                      top: 45,
                      left: 150,
                      child: Center(
                          child: Text(
                        "ETEA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          letterSpacing: 1,
                        ),
                      )),
                    ),
                    const Positioned(
                      top: 80,
                      left: 150,
                      child: Center(
                          child: Text(
                        "QCA-2/G2",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )),
                    ),
                    const Positioned(
                      top: 160,
                      left: 140,
                      child: Center(
                          child: Text(
                        "Subject Wise",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 16,
                            color: Colors.grey),
                      )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Text("1.${'Biology'}",style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("Rs.${'1250.00'}",style: TextStyle(fontWeight: FontWeight.w500),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        decoration: BoxDecoration(color: Colors.green),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add ",
                              style: TextStyle(color: Colors.white,),
                            ),
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                     
                      Text("By :${'Muhammad Bilal'}",style: TextStyle(fontWeight: FontWeight.w500),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
