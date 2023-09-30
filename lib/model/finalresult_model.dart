class FinalResultModels {
  bool? success;
  String? message;
  Data? data;

  FinalResultModels({this.success, this.message, this.data});

  FinalResultModels.fromJson(Map<String, dynamic> json) {
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
  TestDetails? testDetails;
  ResultSummery? resultSummery;
  List<ResultDetails>? resultDetails;

  Data({this.testDetails, this.resultSummery, this.resultDetails});

  Data.fromJson(Map<String, dynamic> json) {
    testDetails = json['test_details'] != null
        ? new TestDetails.fromJson(json['test_details'])
        : null;
    resultSummery = json['result_summery'] != null
        ? new ResultSummery.fromJson(json['result_summery'])
        : null;
    if (json['result_details'] != null) {
      resultDetails = <ResultDetails>[];
      json['result_details'].forEach((v) {
        resultDetails!.add(new ResultDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testDetails != null) {
      data['test_details'] = this.testDetails!.toJson();
    }
    if (this.resultSummery != null) {
      data['result_summery'] = this.resultSummery!.toJson();
    }
    if (this.resultDetails != null) {
      data['result_details'] =
          this.resultDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestDetails {
  String? name;
  String? catName;
  String? id;
  String? instructorId;
  String? categoryId;
  String? masterCourseId;
  Null? instructionLevelId;
  String? courseTitle;
  String? courseSlug;
  Null? keywords;
  Null? overview;
  Null? courseImage;
  Null? thumbImage;
  Null? courseVideo;
  Null? duration;
  String? price;
  Null? strikeOutPrice;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  TestDetails(
      {this.name,
        this.catName,
        this.id,
        this.instructorId,
        this.categoryId,
        this.masterCourseId,
        this.instructionLevelId,
        this.courseTitle,
        this.courseSlug,
        this.keywords,
        this.overview,
        this.courseImage,
        this.thumbImage,
        this.courseVideo,
        this.duration,
        this.price,
        this.strikeOutPrice,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  TestDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catName = json['cat_name'];
    id = json['id'];
    instructorId = json['instructor_id'];
    categoryId = json['category_id'];
    masterCourseId = json['master_course_id'];
    instructionLevelId = json['instruction_level_id'];
    courseTitle = json['course_title'];
    courseSlug = json['course_slug'];
    keywords = json['keywords'];
    overview = json['overview'];
    courseImage = json['course_image'];
    thumbImage = json['thumb_image'];
    courseVideo = json['course_video'];
    duration = json['duration'];
    price = json['price'];
    strikeOutPrice = json['strike_out_price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cat_name'] = this.catName;
    data['id'] = this.id;
    data['instructor_id'] = this.instructorId;
    data['category_id'] = this.categoryId;
    data['master_course_id'] = this.masterCourseId;
    data['instruction_level_id'] = this.instructionLevelId;
    data['course_title'] = this.courseTitle;
    data['course_slug'] = this.courseSlug;
    data['keywords'] = this.keywords;
    data['overview'] = this.overview;
    data['course_image'] = this.courseImage;
    data['thumb_image'] = this.thumbImage;
    data['course_video'] = this.courseVideo;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['strike_out_price'] = this.strikeOutPrice;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ResultSummery {
  String? taId;
  String? stId;
  String? totalQuestions;
  String? givenAnswers;
  String? correctedAnswers;
  String? wrongAnswers;

  ResultSummery(
      {this.taId,
        this.stId,
        this.totalQuestions,
        this.givenAnswers,
        this.correctedAnswers,
        this.wrongAnswers});

  ResultSummery.fromJson(Map<String, dynamic> json) {
    taId = json['ta_id'];
    stId = json['st_id'];
    totalQuestions = json['total_questions'];
    givenAnswers = json['given_answers'];
    correctedAnswers = json['corrected_answers'];
    wrongAnswers = json['wrong_answers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ta_id'] = this.taId;
    data['st_id'] = this.stId;
    data['total_questions'] = this.totalQuestions;
    data['given_answers'] = this.givenAnswers;
    data['corrected_answers'] = this.correctedAnswers;
    data['wrong_answers'] = this.wrongAnswers;
    return data;
  }
}

class ResultDetails {
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
  String? isCorrect;

  ResultDetails(
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
        this.correctedAnswer,
        this.isCorrect});

  ResultDetails.fromJson(Map<String, dynamic> json) {
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
    isCorrect = json['is_correct'];
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
    data['is_correct'] = this.isCorrect;
    return data;
  }
}