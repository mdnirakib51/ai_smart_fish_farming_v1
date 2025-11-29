
class StudentNoticeModel {
  int? id;
  String? title;
  String? description;
  String? file;
  int? status;
  String? createdAt;
  String? updatedAt;

  StudentNoticeModel({
    this.id,
    this.title,
    this.description,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  StudentNoticeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['file'] = file;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}