class Result {
  String? id;
  String? importTestId;
  String? rno;
  String? biologyC;
  String? biologyW;
  dynamic biologyB;
  String? biologyMarks;
  String? chemistryC;
  String? chemistryW;
  dynamic chemistryB;
  String? chemistryMarks;
  String? physicsC;
  String? physicsW;
  dynamic physicsB;
  String? physicsMarks;
  String? englishC;
  String? englishW;
  dynamic englishB;
  String? englishMarks;
  String? logicalReasoningC;
  String? logicalReasoningW;
  dynamic logicalReasoningB;
  String? logicalReasoningMarks;
  String? overAllResultC;
  String? overAllResultW;
  dynamic overAllResultB;
  String? obtainScore;
  String? totalScore;
  String? percentage;
  String? rank;
  String? title;
  String? createdAt;

  Result({
    this.id,
    this.importTestId,
    this.rno,
    this.biologyC,
    this.biologyW,
    this.biologyB,
    this.biologyMarks,
    this.chemistryC,
    this.chemistryW,
    this.chemistryB,
    this.chemistryMarks,
    this.physicsC,
    this.physicsW,
    this.physicsB,
    this.physicsMarks,
    this.englishC,
    this.englishW,
    this.englishB,
    this.englishMarks,
    this.logicalReasoningC,
    this.logicalReasoningW,
    this.logicalReasoningB,
    this.logicalReasoningMarks,
    this.overAllResultC,
    this.overAllResultW,
    this.overAllResultB,
    this.obtainScore,
    this.totalScore,
    this.percentage,
    this.rank,
    this.title,
    this.createdAt,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    importTestId = json["import_test_id"];
    rno = json["rno"];
    biologyC = json["biology_c"];
    biologyW = json["biology_w"];
    biologyB = json["biology_b"];
    biologyMarks = json["biology_marks"];
    chemistryC = json["chemistry_c"];
    chemistryW = json["chemistry_w"];
    chemistryB = json["chemistry_b"];
    chemistryMarks = json["chemistry_marks"];
    physicsC = json["physics_c"];
    physicsW = json["physics_w"];
    physicsB = json["physics_b"];
    physicsMarks = json["physics_marks"];
    englishC = json["english_c"];
    englishW = json["english_w"];
    englishB = json["english_b"];
    englishMarks = json["english_marks"];
    logicalReasoningC = json["logical_reasoning_c"];
    logicalReasoningW = json["logical_reasoning_w"];
    logicalReasoningB = json["logical_reasoning_b"];
    logicalReasoningMarks = json["logical_reasoning_marks"];
    overAllResultC = json["over_all_result_c"];
    overAllResultW = json["over_all_result_w"];
    overAllResultB = json["over_all_result_b"];
    obtainScore = json["obtain_score"];
    totalScore = json["total_score"];
    percentage = json["percentage"];
    rank = json["Rank"];
    title = json["title"];
    createdAt = json["created_at"];
  }

  static List<Result> fromList(List<Map<String, dynamic>> list) {
    return list.map(Result.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["import_test_id"] = importTestId;
    _data["rno"] = rno;
    _data["biology_c"] = biologyC;
    _data["biology_w"] = biologyW;
    _data["biology_b"] = biologyB;
    _data["biology_marks"] = biologyMarks;
    _data["chemistry_c"] = chemistryC;
    _data["chemistry_w"] = chemistryW;
    _data["chemistry_b"] = chemistryB;
    _data["chemistry_marks"] = chemistryMarks;
    _data["physics_c"] = physicsC;
    _data["physics_w"] = physicsW;
    _data["physics_b"] = physicsB;
    _data["physics_marks"] = physicsMarks;
    _data["english_c"] = englishC;
    _data["english_w"] = englishW;
    _data["english_b"] = englishB;
    _data["english_marks"] = englishMarks;
    _data["logical_reasoning_c"] = logicalReasoningC;
    _data["logical_reasoning_w"] = logicalReasoningW;
    _data["logical_reasoning_b"] = logicalReasoningB;
    _data["logical_reasoning_marks"] = logicalReasoningMarks;
    _data["over_all_result_c"] = overAllResultC;
    _data["over_all_result_w"] = overAllResultW;
    _data["over_all_result_b"] = overAllResultB;
    _data["obtain_score"] = obtainScore;
    _data["total_score"] = totalScore;
    _data["percentage"] = percentage;
    _data["Rank"] = rank;
    _data["title"] = title;
    _data["created_at"] = createdAt;
    return _data;
  }
}
