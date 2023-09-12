class TestQuestionModel {
  bool? success;
  String? message;
  Data? data;

  TestQuestionModel({this.success, this.message, this.data});

  TestQuestionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? testId;
  String? questionNo;
  String? questionName;
  String? opt1;
  String? opt2;
  String? opt3;
  String? opt4;
  String? correctAnswer;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.testId,
      this.questionNo,
      this.questionName,
      this.opt1,
      this.opt2,
      this.opt3,
      this.opt4,
      this.correctAnswer,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    questionNo = json['question_no'];
    questionName = json['question_name'];
    opt1 = json['opt_1'];
    opt2 = json['opt_2'];
    opt3 = json['opt_3'];
    opt4 = json['opt_4'];
    correctAnswer = json['correct_answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['question_no'] = this.questionNo;
    data['question_name'] = this.questionName;
    data['opt_1'] = this.opt1;
    data['opt_2'] = this.opt2;
    data['opt_3'] = this.opt3;
    data['opt_4'] = this.opt4;
    data['correct_answer'] = this.correctAnswer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
