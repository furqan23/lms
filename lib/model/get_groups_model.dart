class  GetGroupsModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetGroupsModel({this.success, this.message, this.data});

  GetGroupsModel.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.id,
        this.groupCode,
        this.name,
        this.registrationMethod,
        this.description,
        this.isActive,
        this.totalSeat,
        this.expireOn,
        this.image,
        this.catName,
        this.group_type,
        this.iconClass,
        this.slug,
        this.mscatId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupCode = json['group_code'];
    group_type = json['group_type'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    image = json['image'];
    catName = json['cat_name'];
    iconClass = json['icon_class'];
    slug = json['slug'];
    mscatId = json['mscat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_code'] = this.groupCode;
    data['name'] = this.name;
    data['registration_method'] = this.registrationMethod;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['total_seat'] = this.totalSeat;
    data['expire_on'] = this.expireOn;
    data['group_type'] = this.group_type;
    data['image'] = this.image;
    data['cat_name'] = this.catName;
    data['icon_class'] = this.iconClass;
    data['slug'] = this.slug;
    data['mscat_id'] = this.mscatId;
    return data;
  }
}
