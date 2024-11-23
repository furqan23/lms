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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? courseId;
  String? courseImage;
  String? courseCode;
  String? id;
  String? groupCode;
  String? name;
  String? registrationMethod;
  dynamic description;
  String? isActive;
  String? totalSeat;
  dynamic expireOn;
  String? groupType;
  String? groupName;
  String? masterCategoryId;
  String? groupId;
  String? slug;
  dynamic iconClass;
  dynamic createdAt;
  String? updatedAt;
  String? courseTitle;
  String? firstName;

  Data({
    this.courseId,
    this.courseImage,
    this.courseCode,
    this.id,
    this.groupCode,
    this.name,
    this.registrationMethod,
    this.description,
    this.isActive,
    this.totalSeat,
    this.expireOn,
    this.groupType,
    this.groupName,
    this.masterCategoryId,
    this.groupId,
    this.slug,
    this.iconClass,
    this.createdAt,
    this.updatedAt,
    this.courseTitle,
    this.firstName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'] ?? 'empty';
    courseImage = json["course_image"] ?? "emptyy";
    courseCode = json['course_code'] ?? 'empty';
    id = json['id'] ?? 'empty';
    groupCode = json['group_code'] ?? 'empty';
    name = json['name'] ?? 'empty';
    registrationMethod = json['registration_method'] ?? 'empty';
    description = json['description'] ?? 'empty';
    isActive = json['is_active'] ?? 'empty';
    totalSeat = json['total_seat'] ?? 'empty';
    expireOn = json['expire_on'] ?? 'empty';
    groupType = json['group_type'] ?? 'empty';
    groupName = json['group_name'] ?? 'empty';
    masterCategoryId = json['master_category_id'] ?? 'empty';
    groupId = json['group_id'] ?? 'empty';
    slug = json['slug'] ?? 'empty';
    iconClass = json['icon_class'] ?? 'empty';
    createdAt = json['created_at'] ?? 'empty';
    updatedAt = json['updated_at'] ?? 'empty';
    courseTitle = json['course_title'] ?? 'empty';
    firstName = json['first_name'] ?? 'empty';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['course_id'] = courseId;
    data['course_image'] = courseImage;
    data['course_code'] = courseCode;
    data['id'] = id;
    data['group_code'] = groupCode;
    data['name'] = name;
    data['registration_method'] = registrationMethod;
    data['description'] = description;
    data['is_active'] = isActive;
    data['total_seat'] = totalSeat;
    data['expire_on'] = expireOn;
    data['group_type'] = groupType;
    data['group_name'] = groupName;
    data['master_category_id'] = masterCategoryId;
    data['group_id'] = groupId;
    data['slug'] = slug;
    data['icon_class'] = iconClass;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['course_title'] = courseTitle;
    data['first_name'] = firstName;
    return data;
  }
}
