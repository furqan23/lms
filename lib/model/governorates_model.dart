class GovernoratesModel {
  bool? success;
  String? message;
  List<GovernoratesData>? data;

  GovernoratesModel({this.success, this.message, this.data});

  GovernoratesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GovernoratesData>[];
      json['data'].forEach((v) {
        data!.add(new GovernoratesData.fromJson(v));
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

class GovernoratesData {
  int? id;
  String? title;
  String? titleArabic;
  String? alias;
  String? latitude;
  String? longitude;
  int? status;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  List<Zones>? zones;

  GovernoratesData(
      {this.id,
        this.title,
        this.titleArabic,
        this.alias,
        this.latitude,
        this.longitude,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.zones});

  GovernoratesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleArabic = json['title_arabic'];
    alias = json['alias'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['zones'] != null) {
      zones = <Zones>[];
      json['zones'].forEach((v) {
        zones!.add(new Zones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['title_arabic'] = this.titleArabic;
    data['alias'] = this.alias;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.zones != null) {
      data['zones'] = this.zones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Zones {
  int? id;
  int? governorateId;
  String? title;
  String? titleArabic;
  String? alias;
  String? latitude;
  String? longitude;
  int? status;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  Zones(
      {this.id,
        this.governorateId,
        this.title,
        this.titleArabic,
        this.alias,
        this.latitude,
        this.longitude,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Zones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateId = json['governorate_id'];
    title = json['title'];
    titleArabic = json['title_arabic'];
    alias = json['alias'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['governorate_id'] = this.governorateId;
    data['title'] = this.title;
    data['title_arabic'] = this.titleArabic;
    data['alias'] = this.alias;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}