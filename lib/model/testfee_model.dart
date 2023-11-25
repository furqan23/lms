class TestFee {
  bool? success;
  String? message;
  Data? data;

  TestFee({this.success, this.message, this.data});

  TestFee.fromJson(Map<String, dynamic> json) {
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
  int? testFee;

  Data({this.testFee});

  Data.fromJson(Map<String, dynamic> json) {
    testFee = json['test_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_fee'] = this.testFee;
    return data;
  }
}
