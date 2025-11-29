class StudentExamRoutineModel {
  OrgInfo? orgInfo;
  List<ExamRoutines>? examRoutines;

  StudentExamRoutineModel({this.orgInfo, this.examRoutines});

  StudentExamRoutineModel.fromJson(Map<String, dynamic> json) {
    orgInfo = json['org_info'] != null
        ? OrgInfo.fromJson(json['org_info'])
        : null;
    if (json['exam_routines'] != null) {
      examRoutines = <ExamRoutines>[];
      json['exam_routines'].forEach((v) {
        examRoutines!.add(ExamRoutines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orgInfo != null) {
      data['org_info'] = orgInfo!.toJson();
    }
    if (examRoutines != null) {
      data['exam_routines'] =
          examRoutines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrgInfo {
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

  OrgInfo(
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

  OrgInfo.fromJson(Map<String, dynamic> json) {
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

class ExamRoutines {
  int? id;
  String? date;
  String? title;
  String? year;
  String? classs;
  String? shift;
  String? type;
  String? section;
  String? exam;
  String? routine;
  int? status;
  String? createdAt;
  String? updatedAt;
  YearName? yearName;
  ClassName? className;

  ExamRoutines(
      {this.id,
        this.date,
        this.title,
        this.year,
        this.classs,
        this.shift,
        this.type,
        this.section,
        this.exam,
        this.routine,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.yearName,
        this.className});

  ExamRoutines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'];
    year = json['year'];
    classs = json['classs'];
    shift = json['shift'];
    type = json['type'];
    section = json['section'];
    exam = json['exam'];
    routine = json['routine'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    yearName = json['year_name'] != null
        ? YearName.fromJson(json['year_name'])
        : null;
    className = json['class_name'] != null
        ? ClassName.fromJson(json['class_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['title'] = title;
    data['year'] = year;
    data['classs'] = classs;
    data['shift'] = shift;
    data['type'] = type;
    data['section'] = section;
    data['exam'] = exam;
    data['routine'] = routine;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (yearName != null) {
      data['year_name'] = yearName!.toJson();
    }
    if (className != null) {
      data['class_name'] = className!.toJson();
    }
    return data;
  }
}

class YearName {
  int? id;
  String? year;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  YearName(
      {this.id,
        this.year,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  YearName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ClassName {
  int? id;
  String? className;
  String? numericName;
  int? shiftId;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  ClassName(
      {this.id,
        this.className,
        this.numericName,
        this.shiftId,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  ClassName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    numericName = json['numeric_name'];
    shiftId = json['shift_id'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = className;
    data['numeric_name'] = numericName;
    data['shift_id'] = shiftId;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
