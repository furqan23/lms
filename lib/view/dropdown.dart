import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/model/governorates_model.dart';
import 'package:splashapp/view_model/Controller/drop_controller.dart';
import 'package:shimmer/shimmer.dart';

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({Key? key}) : super(key: key);

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  late final DropController dropController;
  Rx<GovernoratesData?> selectedType =
      Rx<GovernoratesData?>(null); // Make selectedType reactive
  Rx<String?> selectedProperty =
      Rx<String?>(null); // Make selectedProperty reactive

  @override
  void initState() {
    super.initState();
    dropController = Get.put(DropController());
    dropController.homedetailsApi();
  }

  List<String?> getSelectedProperties(GovernoratesData? selected) {
    if (selected != null &&
        selected.zones != null &&
        selected.zones!.isNotEmpty) {
      List<String?> titles = selected.zones!.map((zone) => zone.title).toList();
      return titles;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown"),
      ),
      body: Obx(() {
        // Use Obx to reactively build the UI
        if (dropController.coursemodel.value == null ||
            dropController.coursemodel.value!.isEmpty) {
          return Center(child: ShimmerLoading());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<GovernoratesData?>(
                    padding: const EdgeInsets.only(left: 10),
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: dropController.coursemodel.value!.map((depart) {
                      return DropdownMenuItem<GovernoratesData?>(
                        child: Text(depart.title.toString()),
                        value: depart,
                      );
                    }).toList(),
                    value: selectedType
                        .value, // Use.value to access the current value
                    onChanged: (value) {
                      setState(() {
                        selectedType.value =
                            value; // Update selectedType reactively
                        selectedProperty.value =
                            null; // Clear selected property
                      });
                    },
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 9),
                      child: Text(
                        "Governorates",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  // Conditionally render the second dropdown
                  if (selectedType.value != null) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButton<String?>(
                        padding: const EdgeInsets.only(left: 10),
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: getSelectedProperties(selectedType.value)
                            .map((property) {
                          return DropdownMenuItem<String?>(
                            child: Text(property ?? ""),
                            value: property,
                          );
                        }).toList(),
                        value: selectedProperty
                            .value, // Use.value to access the current value
                        onChanged: (value) {
                          setState(() {
                            selectedProperty.value =
                                value; // Update selectedProperty reactively
                          });
                        },
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 9),
                          child: Text(
                            "Select Property",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Return an empty container if no selection is made
                  }
                }),
              ],
            ),
          );
        }
      }),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
