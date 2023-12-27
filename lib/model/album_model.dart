class AlbumModel {
  bool? success;
  String? message;
  List<Data>? data;

  AlbumModel({this.success, this.message, this.data});

  AlbumModel.fromJson(Map<String, dynamic> json) {
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
  String? albamCode;
  String? albumTitle;

  Data({this.id, this.albamCode, this.albumTitle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albamCode = json['albam_code'];
    albumTitle = json['album_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['albam_code'] = this.albamCode;
    data['album_title'] = this.albumTitle;
    return data;
  }
}
