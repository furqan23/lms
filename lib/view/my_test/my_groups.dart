
import 'package:splashapp/model/get_groups_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import 'package:splashapp/view/my_test/gettest.dart';
import 'package:splashapp/view_model/Controller/test/mygroup_controller.dart';
import 'package:splashapp/widget/group_card.dart';

class MyGroups extends StatefulWidget {
  const MyGroups({super.key});

  @override
  State<MyGroups> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyGroups> {
  final MygroupController mygroupController = Get.put(MygroupController());
  late String token;
  List<GetGroupsModel> _myCoursesList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: Obx(
        () {
          if (isLoading) {
            return const Center(
              child: Text(
                  'No tests available'), // Show text when there are no albums
            );
          } else if (mygroupController.groupmodel.value == null ||
              mygroupController.groupmodel.value!.isEmpty) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show circular progress indicator
            );
          } else {
            return ListView.builder(
              itemCount: mygroupController.groupmodel.value!.length,
              itemBuilder: (context, index) {
                final category = mygroupController.groupmodel.value![index];
                return InkWell(
                  onTap: () {
                    Get.to(() => GetTest(id: category.id.toString()));
                  },
                  child: GroupsCard(
                    id: "${category.groupCode.toString()}-${category.name.toString()}",
                    catName: category.catName.toString() ?? "N/A",
                    name: "${category.description.toString()} ",
                    buttonText: category.group_type.toString(),
                    groupCode: 'aa',
                    registrationMethod: 'aa',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getTokenAndFetchVideos();
  }

  Future<void> getTokenAndFetchVideos() async {
    token = (await LoginController().getTokenFromHive())!;
    print('Token: $token');
    mygroupController.getMyCourseAPI(token);
  }

// void getMyCourseAPI() async {
//   try {
//     // final Map<String, dynamic> requestData = {
//     //   "invoice_id": widget.invoice_id,
//     // };
//
//     // final String requestBody = jsonEncode(requestData);
//
//     final res = await http.get(
//       Uri.parse(AuthApi.getGroupsText),
//       headers: {
//         'Authorization': 'Bearer $token', // Use the retrieved token
//         'Content-Type': 'application/json',
//       },
//     );
//
//     print('Response Status Code: ${res.statusCode}');
//     print('Response groups data long');
//     LogPrint(res.body.toString());
//
//     if (res.statusCode == 200) {
//       if (res.body.isNotEmpty) {
//         final mydata = jsonDecode(res.body);
//         // print('Parsed Data: $mydata');
//         _myCoursesList.add(GetGroupsModel.fromJson(mydata));
//         setState(() {
//           boolData = true;
//         });
//       } else {
//         throw Exception('Empty response');
//       }
//     } else {
//       print('Error: ${res.statusCode}');
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }
}
