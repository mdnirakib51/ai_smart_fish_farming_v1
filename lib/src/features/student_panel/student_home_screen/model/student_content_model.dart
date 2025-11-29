class StudentContentModel {
  List<Contents>? contents;
  SystemSetting? systemSetting;

  StudentContentModel({this.contents, this.systemSetting});

  StudentContentModel.fromJson(Map<String, dynamic> json) {
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
    systemSetting = json['system_setting'] != null
        ? SystemSetting.fromJson(json['system_setting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    if (systemSetting != null) {
      data['system_setting'] = systemSetting!.toJson();
    }
    return data;
  }
}

class Contents {
  int? id;
  String? title;
  String? description;
  String? contentFile;
  String? url;
  int? status;
  int? subjectId;
  int? teacherId;
  String? createdAt;
  String? updatedAt;

  Contents(
      {this.id,
        this.title,
        this.description,
        this.contentFile,
        this.url,
        this.status,
        this.subjectId,
        this.teacherId,
        this.createdAt,
        this.updatedAt});

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    contentFile = json['content_file'];
    url = json['url'];
    status = json['status'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['content_file'] = contentFile;
    data['url'] = url;
    data['status'] = status;
    data['subject_id'] = subjectId;
    data['teacher_id'] = teacherId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SystemSetting {
  int? id;
  String? systemName;
  String? systemTitle;
  String? logo;
  String? bannerImage;
  String? signature;
  String? address;
  String? phone;
  String? email;
  String? currency;
  String? language;
  String? poweredBy;
  String? website;
  int? theme;
  int? softwareStatus;
  String? mapLink;
  String? fbPageLink;
  int? userId;
  int? status;
  String? createdAt;
  String? updatedAt;

  SystemSetting(
      {this.id,
        this.systemName,
        this.systemTitle,
        this.logo,
        this.bannerImage,
        this.signature,
        this.address,
        this.phone,
        this.email,
        this.currency,
        this.language,
        this.poweredBy,
        this.website,
        this.theme,
        this.softwareStatus,
        this.mapLink,
        this.fbPageLink,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt});

  SystemSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemName = json['system_name'];
    systemTitle = json['system_title'];
    logo = json['logo'];
    bannerImage = json['banner_image'];
    signature = json['signature'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    currency = json['currency'];
    language = json['language'];
    poweredBy = json['powered_by'];
    website = json['website'];
    theme = json['theme'];
    softwareStatus = json['software_status'];
    mapLink = json['map_link'];
    fbPageLink = json['fb_page_link'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['system_name'] = systemName;
    data['system_title'] = systemTitle;
    data['logo'] = logo;
    data['banner_image'] = bannerImage;
    data['signature'] = signature;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['currency'] = currency;
    data['language'] = language;
    data['powered_by'] = poweredBy;
    data['website'] = website;
    data['theme'] = theme;
    data['software_status'] = softwareStatus;
    data['map_link'] = mapLink;
    data['fb_page_link'] = fbPageLink;
    data['user_id'] = userId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
