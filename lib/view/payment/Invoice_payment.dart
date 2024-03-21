import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splashapp/values/constants.dart';
import 'package:splashapp/widget/incoming_payment_method_dialog.dart';

import '../../Controller/login_controller.dart';
import '../../model/invoice_model.dart';
import '../../model/get_invoice_id_model.dart' as getinvoice;
import '../../values/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../values/colors.dart';
import '../../values/logs.dart';

class InvoicePayment extends StatefulWidget {
  final String invoice_id;
  final String ref_id;

  InvoicePayment({Key? key, required this.invoice_id, required this.ref_id}) : super(key: key);

  @override
  State<InvoicePayment> createState() => _InvoicePaymentState();
}

class _InvoicePaymentState extends State<InvoicePayment> {
  List<getinvoice.GetInvoiceByIdModel> invoiceByIdList = [];
  String? token;
  InvoiceModel? invoiceData; // Use InvoiceModel to hold the data
  bool isLoading = true;

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
    getShowBankInvoiceApi(widget.invoice_id);
  }

  void getInvoiceAPI() async {
    try {
      final Map<String, dynamic> requestData = {
        "invoice_id": widget.invoice_id,
      };

      final String requestBody = jsonEncode(requestData);
      print("Request Data: $requestData");

      final res = await http.post(
        Uri.parse(AuthApi.postInvoiceById),
        body: requestBody,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body long');
      LogPrint(res.body.toString());

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(res.body);
        setState(() {
          isLoading = false; // Update loading state
          invoiceData = InvoiceModel.fromJson(responseData);

        });
        print('Received Data: $responseData');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size;
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
      appBar: AppBar(
        title: const Text("Payment Detail"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : invoiceData != null
          ? _buildInvoiceDetails(invoiceData!.data!)
          : Center(child: Text('No data')),
    );
  }

  Widget _buildInvoiceDetails(Data data) {
    final w = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8.0, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Invoice #: '),
                Text(widget.invoice_id),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8.0, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ref Id #: '),
                Text(widget.ref_id),
              ],
            ),
          ),

          Expanded(child: ListView(
            shrinkWrap: true,
            children: [
              //Text('Invoice TotalAmount: ${data.inv?.invoiceTotalAmount.toString() ?? 'N/A'}'),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8.0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Payment Status: '),
                    Container(
                      alignment: Alignment.center,
                      width: w.width * .18,
                      height: w.height * .030,
                      decoration: BoxDecoration(
                        color: (data.inv?['status'] as String?) == "un-paid"
                            ? AppColors.redColor
                            : Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        data.inv?['status']?.toString() ?? 'N/A',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // Text('User ID: ${data.inv!.invoiceDetil![0].id}'),
              //Text('price: ${data.inv!.invoiceDetil![0].price}'),
              //Text('price: ${data.inv!.invoiceDetil![0].course!.masterCourse..toString()}'),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           const Text(
              //             "Course Title:  ",
              //             style: textGreyStyle,
              //           ),
              //           Text(data.inv!.invoiceDetil![0].course!.courseTitle.toString()?? "Eata"),
              //         ],
              //       ),
              //
              //       Row(
              //         children: [
              //           const Text(
              //             "Price:  ",
              //             style: textGreyStyle,
              //           ),
              //           Text(data.inv!.invoiceDetil![0].course!.price.toString()?? "Eata"),
              //
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // ...Other widgets to display more details
            ],
          ),),

        ],
      ),
    );
  }
  Future pickImageFromGallery() async {
    final pickedImage = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);

    if (pickedImage == null) return;
    setState(() {
      file = File(pickedImage.path);
    });
    uploadReceipt();
  }

  Future pickImageFromCamera() async {
    final pickedImage = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.camera);

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
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImageFromGallery();
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void uploadReceipt() async {
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
              children: [
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
    File _filee = file!;
    response.headers['Authorization'] = "Bearer $token";
    response.headers['Content-Type'] = 'application/json';
    response.fields['invoice_id'] = widget.invoice_id;
    // response.fields['insuring_expiry'] = formController.issuingExpiryController.text;
    // response.files.add(await http.MultipartFile.fromPath("file", File(file).path),),);
    response.files.add(
      await http.MultipartFile(
          "file", _filee.readAsBytes().asStream(), _filee.lengthSync(),
          filename: _filee.path.toString().split("/").last),
    );

    try {
      var request = await response.send();
      print("${request.statusCode}");
      // Get.snackbar(request.statusCode.toString(), request.headers.toString());
      if (request.statusCode == 200) {
        Map map = jsonDecode(await request.stream.bytesToString());
        print("resp  **************  $map");
        Get.back();
        Get.back();
        // profilePic = null;
        // formController.insuranceImage.value = '';
        // formController.issuingExpiryController.clear();
        // formController.issuingAuthorityController.clear();
        Get.snackbar("Successful", map["message"]);
      } else {
        Get.snackbar("Failed", "Failed Uploading ");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void getShowBankInvoiceApi(String _invoiceId) async {
    try {
      final bodyy = {
        'invoice_id': _invoiceId,
      };

      final res = await http.post(
        Uri.parse("${AuthApi.getInvoiceByIdApi}"),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyy),
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        Get.back();
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          // print('Parsed Data: $mydata');
          invoiceByIdList.add(getinvoice.GetInvoiceByIdModel.fromJson(mydata) );
          Get.dialog(IncomingPaymentMethodDialog(
            invoiceId: mydata["id"],
            status: mydata["status"],
            text: mydata["message"],
            invoiceByIdList: invoiceByIdList,

          ));

          //
          // setState(() {
          //   boolData = true;
          // });
        } else {
          Get.back();
          print('Error: Empty response');
          // Handle empty response here
        }
      } else {
        Get.back();
        print('Error: ${res.statusCode}');
        // Handle other HTTP status codes here
      }
    } catch (e) {
      Get.back();
      print('Error: $e');
      // Handle exceptions here
    }
  }
}