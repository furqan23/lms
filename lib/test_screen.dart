

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/widget/normal_textfiled.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController controllerr=new TextEditingController();

  String textt="";
  String texttPayment="";
  String x="";





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wallet Test Screen"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text("Wallet Amount"),
             NormalFiled(controller: controllerr, hintText: "Enter Text", labelText: "Invoice", textInputType: TextInputType.name),
              SizedBox(height: 30,),
            SizedBox(width: MediaQuery.of(context).size.width,
              child: ElevatedButton(onPressed: () async{
               await getTestkQuickAPI();
              }, child: Text("Check")),
            ),
              Text(textt,style: TextStyle(fontSize: 21),),
              SizedBox(height: 50,),


              SizedBox(width: MediaQuery.of(context).size.width,
                child: ElevatedButton(onPressed: () async{
                  await getPaykQuickAPI();
                }, child: Text("Pay Now")),
              ),
              SizedBox(height: 10,),
              Text(texttPayment,style: TextStyle(fontSize: 21),),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }




  Future getTestkQuickAPI() async {
    try {

      final headerss={
        'username':'QCA@2023#.User1',
        'password':'QCA#2023-.pppp1'

      };


      final bodyy= {
        "consumer_number": controllerr.text.trim().toString(),
        "bank_mnemonic": "kpy".toString(),
      };

      final res = await http.post(Uri.parse(AuthApi.billInquiryApi), headers:headerss,body: bodyy);
      print('url ${AuthApi.billInquiryApi}  headers: $headerss   Response Status Code: ${res.statusCode}');
      print('$bodyy  response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // courseList.add(CourseModel.fromJson(mydata));
          x=mydata["amount_paid"].toString();
          List<String> c = x.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
          c.removeLast();
          c.removeLast();// ['a', 'a', 'a', 'b', 'c']
          print(c.join());
          textt="Consumer Detail:  ${mydata["consumer_Detail"]} \n"
              "Amount Paid:${c.join()}";
          // textt=mydata.toString();
          setState(() {
            // boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }


  Future getPaykQuickAPI() async {
    try {

      final headerss={
        'username':'QCA@2023#.User1',
        'password':'QCA#2023-.pppp1'

      };


      final bodyy= {
        "consumer_number": controllerr.text.trim().toString(),
        "bank_mnemonic": "kpy".toString(),
        "tran_auth_id": "112233",
        "transaction_amount": x,
        "tran_date": "20180911",
        "tran_time": "121366",
      };

      final res = await http.post(Uri.parse(AuthApi.billPaymentApi), headers:headerss,body: bodyy);
      print('url ${AuthApi.billInquiryApi}  headers: $headerss   Response Status Code: ${res.statusCode}');
      print('$bodyy  response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // courseList.add(CourseModel.fromJson(mydata));
          // String x=mydata["amount_paid"].toString();
          // List<String> c = x.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
          // c.removeLast();
          // c.removeLast();// ['a', 'a', 'a', 'b', 'c']
          // print(c.join());
          //

          if(mydata['response_Code']=="00"){
            texttPayment="Status: paid";
          }else{
           texttPayment=mydata['reserved'];}
          setState(() {
            // boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

}
