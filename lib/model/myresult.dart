class MyResultModel {
  bool? success;
  String? message;
  List<Data>? data;

  MyResultModel({this.success, this.message, this.data});

  MyResultModel.fromJson(Map<String, dynamic> json) {
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
  String? courseImage;
  Null? thumbImage;
  String? courseVideo;
  Null? duration;
  String? price;
  Null? strikeOutPrice;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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