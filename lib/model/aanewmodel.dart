class GetGroupsModel {
  bool? success;
  String? message;
  Map<String, List<Data>>? data;

  GetGroupsModel({this.success, this.message, this.data});

  GetGroupsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = {};
      json['data'].forEach((key, value) {
        data![key] = (value as List).map((v) => Data.fromJson(v)).toList();
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((key, value) => MapEntry(key, value.map((v) => v.toJson()).toList()));
    }
    return map;
  }
}

class Data {
  String? id;
  String? groupCode;
  String? name;
  String? registrationMethod;
  var description;
  String? isActive;
  String? totalSeat;
  var expireOn;
  var image;
  var group_type;
  String? catName;
  var iconClass;
  String? slug;
  String? mscatId;
  String? year;
  String? createdAt;

  Data({
    this.id,
    this.groupCode,
    this.name,
    this.registrationMethod,
    this.description,
    this.isActive,
    this.totalSeat,
    this.expireOn,
    this.image,
    this.group_type,
    this.catName,
    this.iconClass,
    this.slug,
    this.mscatId,
    this.year,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupCode = json['group_code'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    image = json['image'];
    group_type = json['group_type'];
    catName = json['cat_name'];
    iconClass = json['icon_class'];
    slug = json['slug'];
    mscatId = json['mscat_id'];
    year = json['year'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['group_code'] = groupCode;
    map['name'] = name;
    map['registration_method'] = registrationMethod;
    map['description'] = description;
    map['is_active'] = isActive;
    map['total_seat'] = totalSeat;
    map['expire_on'] = expireOn;
    map['image'] = image;
    map['group_type'] = group_type;
    map['cat_name'] = catName;
    map['icon_class'] = iconClass;
    map['slug'] = slug;
    map['mscat_id'] = mscatId;
    map['year'] = year;
    map['createdAt'] = createdAt;
    return map;
  }
}
