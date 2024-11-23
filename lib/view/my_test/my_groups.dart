import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/logs.dart';
import '../../widget/group_card.dart';
import '../../view/my_test/gettest.dart';
import '../../model/aanewmodel.dart';
import 'package:http/http.dart' as http;

class MyGroups extends StatefulWidget {
  const MyGroups({super.key});

  @override
  State<MyGroups> createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  String? token;

  Map<String, List<Data>> groupsByYear = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    token = await LoginController().getTokenFromHive();
    if (token != null) {
      getGroupsAPI();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getGroupsAPI() async {
    try {
      final res = await http.get(
        Uri.parse(AuthApi.getGroupsText),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      LogPrint('Response Status Code: ${res.statusCode}');
      LogPrint('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        final responseJson = jsonDecode(res.body);
        if (responseJson['success'] == true) {
          final model = GetGroupsModel.fromJson(responseJson);
          setState(() {
            groupsByYear = model.data ?? {};
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      LogPrint(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> fetchGroups() async {
  //   try {
  //     final String jsonString =
  //         await rootBundle.loadString('lib/model/aajson.json');
  //     final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

  //     final Map<String, List<Data>> parsedGroups = {};
  //     jsonResponse.forEach((year, groups) {
  //       parsedGroups[year] =
  //           (groups as List).map((e) => Data.fromJson(e)).toList();
  //     });

  //     setState(() {
  //       groupsByYear = parsedGroups;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     debugPrint("Error loading static groups data: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : groupsByYear.isEmpty
              ? const Center(
                  child: Text("No Groups Found"),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  itemCount: groupsByYear.keys.length,
                  itemBuilder: (context, yearIndex) {
                    String year = groupsByYear.keys.elementAt(yearIndex);
                    List<Data> groups = groupsByYear[year] ?? [];

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          year,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        leading: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        children: groups.map((group) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 2.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => GetTest(
                                      id: group.id.toString(),
                                    ));
                              },
                              child: GroupsCard(
                                id: "${group.groupCode}-${group.name} ",
                                catName: group.catName ?? "N/A",
                                name: group.description ?? "No Description",
                                buttonText:
                                    group.group_type?.toString() ?? "N/A",
                                groupCode: group.groupCode ?? "",
                                registrationMethod:
                                    group.registrationMethod ?? "",
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
