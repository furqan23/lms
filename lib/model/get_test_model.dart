class GetTestModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetTestModel({this.success, this.message, this.data});

  GetTestModel.fromJson(Map<String, dynamic> json) {
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
  String? courseId;
  String? testTitle;
  String? totalTime;
  String? testStart;
  String? testEnd;
  String? timeStart;
  String? timeEnd;
  String? userId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.courseId,
        this.testTitle,
        this.totalTime,
        this.testStart,
        this.testEnd,
        this.timeStart,
        this.timeEnd,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    testTitle = json['test_title'];
    totalTime = json['total_time'];
    testStart = json['test_start'];
    testEnd = json['test_end'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['test_title'] = this.testTitle;
    data['total_time'] = this.totalTime;
    data['test_start'] = this.testStart;
    data['test_end'] = this.testEnd;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
