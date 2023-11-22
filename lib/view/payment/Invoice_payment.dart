import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splashapp/values/constants.dart';

import '../../Controller/login_controller.dart';
import '../../model/invoice_model.dart';
import '../../values/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../values/colors.dart';

class InvoicePayment extends StatefulWidget {
  final String invoice_id;

  InvoicePayment({super.key, required this.invoice_id});

  @override
  State<InvoicePayment> createState() => _InvoicePaymentState();
}

class _InvoicePaymentState extends State<InvoicePayment> {
  String? token;
  List<InvoiceModel> invoiceList = [];
  bool boolData = false;
  File? file;

  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getInvoiceAPI();
  }

  void getInvoiceAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "invoice_id": widget.invoice_id,
      };

      final String requestBody = jsonEncode(requestData);

      final res = await http.post(
        Uri.parse(AuthApi.postInvoiceById),
        body: requestBody,
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');
          invoiceList.add(InvoiceModel.fromJson(mydata));
          setState(() {
            boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          // Respond to button press
          dialogue(context);
        },
        icon: const Icon(Icons.upload_file_outlined),
        label: const Text('Upload Receipt'),
      ),
      appBar: AppBar(title: const Text("Payment Detail"),),
      body: boolData==false ?const Center(child: CircularProgressIndicator())
          :Card(
        elevation: 5,
            child: Column(
        children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(12,8.0,12,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Invoice #: '),
                  Text(widget.invoice_id),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,8.0,12,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount: '),
                  Text("PKR: ${totalAmountMethod()}"),
                ],
              ),
            ),// Display the token
            Padding(
              padding: const EdgeInsets.fromLTRB(12,8.0,12,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Payment Status: '),
                  Container(
                    alignment: Alignment.center,
                    width: w.width * .18,
                    height: w.height * .030,
                    decoration: BoxDecoration(
                      color:invoiceList[0].data!.status.toString()=="un-paid" ? AppColors.redColor : Colors
                          .green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      invoiceList[0].data!.status.toString(), style: const TextStyle(color: Colors.white),),),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: invoiceList[0].data!.invoiceDetil!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0,8.0,0,3),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                          //  Text('Token: $token'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [

                                      Text(invoiceList[0].data!.invoiceDetil![index].category!.name!.toString()),
                                      const Text(" /",style: textGreyStyle),
                                      Text(invoiceList[0].data!.invoiceDetil![index].groups!.name!.toString()),
                                    ],
                                  ),
                        //           Row(
                        //             children: [
                        //               Text('/',style: textGreyStyle),
                        // Text(invoiceList[0].data!.invoiceDetil![index].groups!.name!.toString()),
                        //             ],
                        //           ),
                                ],
                              ),
                            ), // Display the invoice_id

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Course Title:  ",style: textGreyStyle,),
                                      Text(invoiceList[0].data!.invoiceDetil![index].course!.courseTitle!.toString()),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      const Text("Price:  ",style: textGreyStyle,),
                                      Text(invoiceList[0].data!.invoiceDetil![index].course!.price!.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
          ),
    );
  }



  Future pickImageFromGallery() async {
    final pickedImage = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);

    if (pickedImage == null) return;
    setState(() {
      file = File(pickedImage.path);
    });
    uploadReceipt();
  }
  Future pickImageFromCamera() async {
    final pickedImage =
    await ImagePicker.platform.getImageFromSource(source: ImageSource.camera);

    if (pickedImage == null) return;

    setState(() {
      file = File(pickedImage.path);
    });
    uploadReceipt();
  }
  void dialogue(context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            height: 120.0,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickImageFromCamera();
                    Navigator.pop(context);
                  },
                  leading:const Icon(Icons.camera_alt_rounded),
                  title:const Text("Camera"),
                ),
                ListTile(
                  onTap: (){

                    pickImageFromGallery();
                    Navigator.pop(context);

                  },
                  leading:const Icon(Icons.photo_library),
                  title:const Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void uploadReceipt()async
  {
    FocusScope.of(context).unfocus();
    Size size = Get.size;
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            height: size.height * 0.10,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              [
                CircularProgressIndicator(),
                Text("please wait..."),
              ],
            ),
          ),
        );
      },
    );
    const String url = AuthApi.uploadReceiptApi;


    final response = http.MultipartRequest("POST", Uri.parse(url));
    File _filee=file!;
    response.headers['Authorization'] = "Bearer $token";
    response.headers['Content-Type'] = 'application/json';
    response.fields['invoice_id'] = widget.invoice_id;
    // response.fields['insuring_expiry'] = formController.issuingExpiryController.text;
    // response.files.add(await http.MultipartFile.fromPath("file", File(file).path),),);
    response.files.add(await http.MultipartFile("file",_filee.readAsBytes().asStream(),_filee.lengthSync(),filename: _filee.path.toString().split("/").last),);


    try{
      var request = await response.send();
      print("${request.statusCode}");
      // Get.snackbar(request.statusCode.toString(), request.headers.toString());
      if(request.statusCode == 200)
      {
        Map map=jsonDecode(await request.stream.bytesToString());
        print("resp  **************  $map");
        Get.back();
        Get.back();
        // profilePic = null;
        // formController.insuranceImage.value = '';
        // formController.issuingExpiryController.clear();
        // formController.issuingAuthorityController.clear();
      Get.snackbar("Successful", map["message"]);

      }
      else
      {
        Get.snackbar("Failed", "Failed Uploading ");
      }
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  double totalAmountMethod(){
    double totalAmount = 0.0;
    for (var invoice in invoiceList[0].data!.invoiceDetil!) {
      totalAmount +=
          double.tryParse(invoice.price.toString()) ?? 0.0;
    }
return totalAmount;
  }
}
