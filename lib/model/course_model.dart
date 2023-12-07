class CourseModel {
  bool? success;
  String? message;
  List<Data>? data;

  CourseModel({this.success, this.message, this.data});

  CourseModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? groupcode;
  String? registrationMethod;
  String? description; // Update here to remove nullability
  String? isActive;
  String? totalSeat;
  String? expireOn;
  String? catName;
  List<Courses>? courses;

  Data({
    this.id,
    this.name,
    this.registrationMethod,
    this.description,
    this.groupcode,
    this.isActive,
    this.totalSeat,
    this.expireOn,
    this.catName,
    this.courses,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description']; // Handle nullability here
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    groupcode = json['group_code'];
    catName = json['cat_name'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['registration_method'] = registrationMethod;
    data['description'] = description; // Update nullability handling here
    data['is_active'] = isActive;
    data['total_seat'] = totalSeat;
    data['expire_on'] = expireOn;
    data['group_code'] = groupcode;
    data['cat_name'] = catName;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? id;
  String? classtime;
  String? instructorId;
  String? categoryId;
  String? masterCourseId;
  String? instructionLevelId;
  String? courseTitle;
  String? courseSlug;
  String? keywords;
  String? overview;
  String? courseImage;
  String? thumbImage;
  String? courseVideo;
  String? duration;
  String? price;
  String? strikeOutPrice;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;

  Courses({
    this.id,
    this.instructorId,
    this.categoryId,
    this.masterCourseId,
    this.instructionLevelId,
    this.courseTitle,
    this.classtime,
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
    this.updatedAt,
    this.firstName,
    this.lastName,
  });

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorId = json['instructor_id'];
    categoryId = json['category_id'];
    masterCourseId = json['master_course_id'];
    instructionLevelId = json['instruction_level_id'];
    courseTitle = json['course_title'];
    classtime = json['class_time'];
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
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['instructor_id'] = instructorId;
    data['category_id'] = categoryId;
    data['master_course_id'] = masterCourseId;
    data['instruction_level_id'] = instructionLevelId;
    data['course_title'] = courseTitle;
    data['class_time'] = classtime;
    data['course_slug'] = courseSlug;
    data['keywords'] = keywords;
    data['overview'] = overview;
    data['course_image'] = courseImage;
    data['thumb_image'] = thumbImage;
    data['course_video'] = courseVideo;
    data['duration'] = duration;
    data['price'] = price;
    data['strike_out_price'] = strikeOutPrice;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
