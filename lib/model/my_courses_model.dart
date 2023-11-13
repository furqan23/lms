

class MyCoursesModel {
  bool? success;
  String? message;
  List<Data>? data;

  MyCoursesModel({this.success, this.message, this.data});

  MyCoursesModel.fromJson(Map<String, dynamic> json) {
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
  String? courseId;
  String? id;
  String? name;
  String? registrationMethod;
  var description;
  String? isActive;
  String? totalSeat;
  var expireOn;
  String? masterCategoryId;
  String? groupId;
  String? slug;
  var iconClass;
  var createdAt;
  var updatedAt;
  String? courseTitle;
  String? firstName;
  String? lastName;

  Data(
      {this.courseId,
        this.id,
        this.name,
        this.registrationMethod,
        this.description,
        this.isActive,
        this.totalSeat,
        this.expireOn,
        this.masterCategoryId,
        this.groupId,
        this.slug,
        this.iconClass,
        this.createdAt,
        this.updatedAt,
        this.courseTitle,
        this.firstName,
        this.lastName});

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    id = json['id'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    masterCategoryId = json['master_category_id'];
    groupId = json['group_id'];
    slug = json['slug'];
    iconClass = json['icon_class'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseTitle = json['course_title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['registration_method'] = this.registrationMethod;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['total_seat'] = this.totalSeat;
    data['expire_on'] = this.expireOn;
    data['master_category_id'] = this.masterCategoryId;
    data['group_id'] = this.groupId;
    data['slug'] = this.slug;
    data['icon_class'] = this.iconClass;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_title'] = this.courseTitle;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
