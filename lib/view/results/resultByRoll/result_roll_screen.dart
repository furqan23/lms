import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:splashapp/model/search_roll_result_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:http/http.dart' as http;

class ResultRollScreen extends StatefulWidget {
  const ResultRollScreen({super.key});

  @override
  State<ResultRollScreen> createState() => _ResultRollScreenState();
}

class _ResultRollScreenState extends State<ResultRollScreen> {
  final TextEditingController _rollNumberController = TextEditingController();
  Result? searchResult;
  bool isLoading = false;
  String? errorMessage;

  Future<void> _searchResults() async {
    String rollNumber = _rollNumberController.text.trim();

    if (rollNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a roll number")),
      );
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      searchResult = await fetchResultByRollNumber(rollNumber);
    } catch (error) {
      errorMessage = error.toString();
      searchResult = null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _rollNumberController.clear();
    setState(() {
      searchResult = null;
      errorMessage = null;
    });
  }

  Future<Result> fetchResultByRollNumber(String rollNumber) async {
    final url =
        Uri.parse("${AuthApi.baseUrlWeb}/get-result-record/$rollNumber");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Result.fromJson(data);
      } else {
        throw Exception(
            "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("An error occurred: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Roll Number",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _rollNumberController,
                      decoration: InputDecoration(
                        hintText: "Roll Number",
                        suffixIcon: IconButton(
                          onPressed: isLoading ? null : _searchResults,
                          icon: isLoading
                              ? const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: _clearSearch,
                    icon: const Icon(Icons.clear),
                    tooltip: "Clear",
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              else if (searchResult == null)
                const Center(
                  child: Text(
                    "No results found.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Results Table
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 25,
                        columns: const [
                          DataColumn(label: Text("Subject")),
                          DataColumn(label: Text("C")),
                          DataColumn(label: Text("W")),
                          DataColumn(label: Text("B")),
                          DataColumn(label: Text("Marks")),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text("Biology")),
                            DataCell(Text(searchResult!.biologyC ?? "-")),
                            DataCell(Text(searchResult!.biologyW ?? "-")),
                            DataCell(Text(searchResult!.biologyB ?? "-")),
                            DataCell(Text(searchResult!.biologyMarks ?? "-")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Chemistry")),
                            DataCell(Text(searchResult!.chemistryMarks ?? "-")),
                            DataCell(Text(searchResult!.chemistryW ?? "-")),
                            DataCell(Text(searchResult!.chemistryB ?? "-")),
                            DataCell(Text(searchResult!.chemistryMarks ?? "-")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Physics")),
                            DataCell(Text(searchResult!.physicsMarks ?? "-")),
                            DataCell(Text(searchResult!.physicsW ?? "-")),
                            DataCell(Text(searchResult!.physicsB ?? "-")),
                            DataCell(Text(searchResult!.physicsMarks ?? "-")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("English")),
                            DataCell(Text(searchResult!.englishMarks ?? "-")),
                            DataCell(Text(searchResult!.englishW ?? "-")),
                            DataCell(Text(searchResult!.englishB ?? "-")),
                            DataCell(Text(searchResult!.englishMarks ?? "-")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Logical Rg")),
                            DataCell(Text(
                                searchResult!.logicalReasoningMarks ?? "-")),
                            DataCell(
                                Text(searchResult!.logicalReasoningW ?? "-")),
                            DataCell(
                                Text(searchResult!.logicalReasoningB ?? "-")),
                            DataCell(Text(
                                searchResult!.logicalReasoningMarks ?? "-")),
                          ]),
                          // Overall Result
                          DataRow(cells: [
                            DataCell(Text("Total Result")),
                            DataCell(Text(searchResult!.totalScore ?? "-")),
                            DataCell(Text(searchResult!.overAllResultW ?? "-")),
                            DataCell(Text(searchResult!.overAllResultB ?? "-")),
                            DataCell(Text(searchResult!.totalScore ?? "-")),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Overall Summary
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Overall Summary",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Total Score: ${searchResult!.obtainScore ?? "0"}/200",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Percentage: ${searchResult!.percentage ?? "0"}%",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Rank: ${searchResult!.rank ?? "-"}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
