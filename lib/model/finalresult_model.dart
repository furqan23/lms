class FinalResultModels {
  bool? success;
  String? message;
  List<Data>? data;

  FinalResultModels({this.success, this.message, this.data});

  FinalResultModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? taId;
  String? userId;
  String? qId;
  String? givenAnswer;
  String? correctedAnswer;

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
        this.updatedAt,
        this.taId,
        this.userId,
        this.qId,
        this.givenAnswer,
        this.correctedAnswer});

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
    taId = json['ta_id'];
    userId = json['user_id'];
    qId = json['q_id'];
    givenAnswer = json['given_answer'];
    correctedAnswer = json['corrected_answer'];
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
    data['ta_id'] = this.taId;
    data['user_id'] = this.userId;
    data['q_id'] = this.qId;
    data['given_answer'] = this.givenAnswer;
    data['corrected_answer'] = this.correctedAnswer;
    return data;
  }
}