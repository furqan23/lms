class DashboardModelWithSlider {
  bool? success;
  String? message;
  Data? data;

  DashboardModelWithSlider({this.success, this.message, this.data});

  DashboardModelWithSlider.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;
  List<Slides>? slides;

  Data({this.category, this.slides});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(new Slides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.slides != null) {
      data['slides'] = this.slides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? registrationMethod;
  Null? description;
  String? isActive;
  String? totalSeat;
  Null? expireOn;
  String? catName;
  Null? iconClass;
  String? slug;
  String? mscatId;

  Category(
      {this.id,
        this.name,
        this.registrationMethod,
        this.description,
        this.isActive,
        this.totalSeat,
        this.expireOn,
        this.catName,
        this.iconClass,
        this.slug,
        this.mscatId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    catName = json['cat_name'];
    iconClass = json['icon_class'];
    slug = json['slug'];
    mscatId = json['mscat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['registration_method'] = this.registrationMethod;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['total_seat'] = this.totalSeat;
    data['expire_on'] = this.expireOn;
    data['cat_name'] = this.catName;
    data['icon_class'] = this.iconClass;
    data['slug'] = this.slug;
    data['mscat_id'] = this.mscatId;
    return data;
  }
}

class Slides {
  int? id;
  String? filePath;

  Slides({this.id, this.filePath});

  Slides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_path'] = this.filePath;
    return data;
  }
}
