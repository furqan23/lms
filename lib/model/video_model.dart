class VideoModel {
  bool? success;
  String? message;
  List<Data>? data;

  VideoModel({this.success, this.message, this.data});

  VideoModel.fromJson(Map<String, dynamic> json) {
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
  String? videoTitle;
  String? videoName;
  Null? videoType;
  String? courseAlbumId;
  Null? duration;
  Null? imageName;
  Null? videoTag;
  Null? uploaderId;
  String? processed;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.videoTitle,
        this.videoName,
        this.videoType,
        this.courseAlbumId,
        this.duration,
        this.imageName,
        this.videoTag,
        this.uploaderId,
        this.processed,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoTitle = json['video_title'];
    videoName = json['video_name'];
    videoType = json['video_type'];
    courseAlbumId = json['course_album_id'];
    duration = json['duration'];
    imageName = json['image_name'];
    videoTag = json['video_tag'];
    uploaderId = json['uploader_id'];
    processed = json['processed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_title'] = this.videoTitle;
    data['video_name'] = this.videoName;
    data['video_type'] = this.videoType;
    data['course_album_id'] = this.courseAlbumId;
    data['duration'] = this.duration;
    data['image_name'] = this.imageName;
    data['video_tag'] = this.videoTag;
    data['uploader_id'] = this.uploaderId;
    data['processed'] = this.processed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}