
class StudentProfileModel {
  Organization? organization;
  Student? student;
  StudentDetail? studentDetail;
  StudentInfo? studentInfo;

  StudentProfileModel({this.organization, this.student, this.studentDetail, this.studentInfo});

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    organization = json['organization'] != null ? Organization.fromJson(json['organization']) : null;
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
    studentDetail = json['student_detail'] != null
        ? StudentDetail.fromJson(json['student_detail'])
        : null;
    studentInfo = json['student_info'] != null
        ? StudentInfo.fromJson(json['student_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    if (studentDetail != null) {
      data['student_detail'] = studentDetail!.toJson();
    }
    if (studentInfo != null) {
      data['student_info'] = studentInfo!.toJson();
    }
    return data;
  }
}

class Organization {
  String? systemName;
  String? systemTitle;
  String? logo;
  String? bannerImage;
  String? signature;
  String? address;
  String? phone;
  String? email;
  String? poweredBy;
  String? website;
  String? mapLink;
  String? fbPageLink;

  Organization(
      {this.systemName,
        this.systemTitle,
        this.logo,
        this.bannerImage,
        this.signature,
        this.address,
        this.phone,
        this.email,
        this.poweredBy,
        this.website,
        this.mapLink,
        this.fbPageLink});

  Organization.fromJson(Map<String, dynamic> json) {
    systemName = json['system_name'];
    systemTitle = json['system_title'];
    logo = json['logo'];
    bannerImage = json['banner_image'];
    signature = json['signature'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    poweredBy = json['powered_by'];
    website = json['website'];
    mapLink = json['map_link'];
    fbPageLink = json['fb_page_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['system_name'] = systemName;
    data['system_title'] = systemTitle;
    data['logo'] = logo;
    data['banner_image'] = bannerImage;
    data['signature'] = signature;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['powered_by'] = poweredBy;
    data['website'] = website;
    data['map_link'] = mapLink;
    data['fb_page_link'] = fbPageLink;
    return data;
  }
}


class Student {
  int? id;
  String? name;
  int? classId;
  int? sectionId;
  String? fatherName;
  String? fatherOccupation;
  String? motherName;
  String? motherOccupation;
  String? birthdate;
  String? birthRegNo;
  String? gender;
  String? address;
  String? permanentAddress;
  String? houseNo;
  String? roadNo;
  String? houseOwnerName;
  String? village;
  String? wardNo;
  String? union;
  String? postalCode;
  String? thana;
  String? district;
  String? permanentHouseNo;
  String? permanentRoadNo;
  String? permanentHouseOwnerName;
  String? permanentVillage;
  String? permanentWardNo;
  String? permanentUnion;
  String? permanentPostalCode;
  String? permanentThana;
  String? permanentDistrict;
  String? phone;
  String? bloodGroup;
  String? email;
  String? password;
  String? photo;
  String? fatherNid;
  String? motherNid;
  String? fPhoto;
  String? mPhoto;
  String? uniqueId;
  String? birthCertificate;
  String? birthCertificateNo;
  String? academicCertificate1;
  String? academicCertificate2;
  String? fPhone;
  String? mPhone;
  String? gPhone;
  String? gName;
  String? quata;
  String? religion;
  String? nationality;
  String? cardId;
  String? feePayDate;
  String? txnNo;
  int? userId;
  String? entryBy;
  int? status;
  String? createdAt;
  String? updatedAt;

  Student(
      {this.id,
        this.name,
        this.classId,
        this.sectionId,
        this.fatherName,
        this.fatherOccupation,
        this.motherName,
        this.motherOccupation,
        this.birthdate,
        this.birthRegNo,
        this.gender,
        this.address,
        this.permanentAddress,
        this.houseNo,
        this.roadNo,
        this.houseOwnerName,
        this.village,
        this.wardNo,
        this.union,
        this.postalCode,
        this.thana,
        this.district,
        this.permanentHouseNo,
        this.permanentRoadNo,
        this.permanentHouseOwnerName,
        this.permanentVillage,
        this.permanentWardNo,
        this.permanentUnion,
        this.permanentPostalCode,
        this.permanentThana,
        this.permanentDistrict,
        this.phone,
        this.bloodGroup,
        this.email,
        this.password,
        this.photo,
        this.fatherNid,
        this.motherNid,
        this.fPhoto,
        this.mPhoto,
        this.uniqueId,
        this.birthCertificate,
        this.birthCertificateNo,
        this.academicCertificate1,
        this.academicCertificate2,
        this.fPhone,
        this.mPhone,
        this.gPhone,
        this.gName,
        this.quata,
        this.religion,
        this.nationality,
        this.cardId,
        this.feePayDate,
        this.txnNo,
        this.userId,
        this.entryBy,
        this.status,
        this.createdAt,
        this.updatedAt});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    fatherName = json['father_name'];
    fatherOccupation = json['father_occupation'];
    motherName = json['mother_name'];
    motherOccupation = json['mother_occupation'];
    birthdate = json['birthdate'];
    birthRegNo = json['birth_reg_no'];
    gender = json['gender'];
    address = json['address'];
    permanentAddress = json['permanent_address'];
    houseNo = json['house_no'];
    roadNo = json['road_no'];
    houseOwnerName = json['house_owner_name'];
    village = json['village'];
    wardNo = json['ward_no'];
    union = json['union'];
    postalCode = json['postal_code'];
    thana = json['thana'];
    district = json['district'];
    permanentHouseNo = json['permanent_house_no'];
    permanentRoadNo = json['permanent_road_no'];
    permanentHouseOwnerName = json['permanent_house_owner_name'];
    permanentVillage = json['permanent_village'];
    permanentWardNo = json['permanent_ward_no'];
    permanentUnion = json['permanent_union'];
    permanentPostalCode = json['permanent_postal_code'];
    permanentThana = json['permanent_thana'];
    permanentDistrict = json['permanent_district'];
    phone = json['phone'];
    bloodGroup = json['blood_group'];
    email = json['email'];
    password = json['password'];
    photo = json['photo'];
    fatherNid = json['father_nid'];
    motherNid = json['mother_nid'];
    fPhoto = json['f_photo'];
    mPhoto = json['m_photo'];
    uniqueId = json['unique_id'];
    birthCertificate = json['birth_certificate'];
    birthCertificateNo = json['birth_certificate_no'];
    academicCertificate1 = json['academic_certificate_1'];
    academicCertificate2 = json['academic_certificate_2'];
    fPhone = json['f_phone'];
    mPhone = json['m_phone'];
    gPhone = json['g_phone'];
    gName = json['g_name'];
    quata = json['quata'];
    religion = json['religion'];
    nationality = json['nationality'];
    cardId = json['card_id'];
    feePayDate = json['fee_pay_date'];
    txnNo = json['txn_no'];
    userId = json['user_id'];
    entryBy = json['entry_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['father_name'] = fatherName;
    data['father_occupation'] = fatherOccupation;
    data['mother_name'] = motherName;
    data['mother_occupation'] = motherOccupation;
    data['birthdate'] = birthdate;
    data['birth_reg_no'] = birthRegNo;
    data['gender'] = gender;
    data['address'] = address;
    data['permanent_address'] = permanentAddress;
    data['house_no'] = houseNo;
    data['road_no'] = roadNo;
    data['house_owner_name'] = houseOwnerName;
    data['village'] = village;
    data['ward_no'] = wardNo;
    data['union'] = union;
    data['postal_code'] = postalCode;
    data['thana'] = thana;
    data['district'] = district;
    data['permanent_house_no'] = permanentHouseNo;
    data['permanent_road_no'] = permanentRoadNo;
    data['permanent_house_owner_name'] = permanentHouseOwnerName;
    data['permanent_village'] = permanentVillage;
    data['permanent_ward_no'] = permanentWardNo;
    data['permanent_union'] = permanentUnion;
    data['permanent_postal_code'] = permanentPostalCode;
    data['permanent_thana'] = permanentThana;
    data['permanent_district'] = permanentDistrict;
    data['phone'] = phone;
    data['blood_group'] = bloodGroup;
    data['email'] = email;
    data['password'] = password;
    data['photo'] = photo;
    data['father_nid'] = fatherNid;
    data['mother_nid'] = motherNid;
    data['f_photo'] = fPhoto;
    data['m_photo'] = mPhoto;
    data['unique_id'] = uniqueId;
    data['birth_certificate'] = birthCertificate;
    data['birth_certificate_no'] = birthCertificateNo;
    data['academic_certificate_1'] = academicCertificate1;
    data['academic_certificate_2'] = academicCertificate2;
    data['f_phone'] = fPhone;
    data['m_phone'] = mPhone;
    data['g_phone'] = gPhone;
    data['g_name'] = gName;
    data['quata'] = quata;
    data['religion'] = religion;
    data['nationality'] = nationality;
    data['card_id'] = cardId;
    data['fee_pay_date'] = feePayDate;
    data['txn_no'] = txnNo;
    data['user_id'] = userId;
    data['entry_by'] = entryBy;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class StudentDetail {
  int? id;
  String? sectionName;
  String? nickName;
  int? studentId;
  int? classId;
  int? groupId;
  int? shiftId;
  int? sectionId;
  int? sessionId;
  int? mediumId;
  int? roll;
  String? regNo;
  int? uniqueId;
  int? payableTutionFee;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Shift? shift;
  Session? session;
  ClassData? classData;
  Section? section;
  Group? group;

  StudentDetail(
      {this.id,
        this.sectionName,
        this.nickName,
        this.studentId,
        this.classId,
        this.groupId,
        this.shiftId,
        this.sectionId,
        this.sessionId,
        this.mediumId,
        this.roll,
        this.regNo,
        this.uniqueId,
        this.payableTutionFee,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.shift,
        this.session,
        this.classData,
        this.section,
        this.group});

  StudentDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
    nickName = json['nick_name'];
    studentId = json['student_id'];
    classId = json['class_id'];
    groupId = json['group_id'];
    shiftId = json['shift_id'];
    sectionId = json['section_id'];
    sessionId = json['session_id'];
    mediumId = json['medium_id'];
    roll = json['roll'];
    regNo = json['reg_no'];
    uniqueId = json['unique_id'];
    payableTutionFee = json['payable_tution_fee'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shift = json['shift'] != null ? Shift.fromJson(json['shift']) : null;
    session =
    json['session'] != null ? Session.fromJson(json['session']) : null;
    classData =
    json['class'] != null ? ClassData.fromJson(json['class']) : null;
    section =
    json['section'] != null ? Section.fromJson(json['section']) : null;
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_name'] = sectionName;
    data['nick_name'] = nickName;
    data['student_id'] = studentId;
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['shift_id'] = shiftId;
    data['section_id'] = sectionId;
    data['session_id'] = sessionId;
    data['medium_id'] = mediumId;
    data['roll'] = roll;
    data['reg_no'] = regNo;
    data['unique_id'] = uniqueId;
    data['payable_tution_fee'] = payableTutionFee;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (shift != null) {
      data['shift'] = shift!.toJson();
    }
    if (session != null) {
      data['session'] = session!.toJson();
    }
    if (classData != null) {
      data['class'] = classData!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class Shift {
  int? id;
  String? shiftName;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Shift(
      {this.id,
        this.shiftName,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shiftName = json['shift_name'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shift_name'] = shiftName;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Session {
  int? id;
  String? year;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Session(
      {this.id,
        this.year,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Session.fromJson(Map<String, dynamic> json) {
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

class ClassData {
  int? id;
  String? className;
  String? numericName;
  int? shiftId;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  ClassData(
      {this.id,
        this.className,
        this.numericName,
        this.shiftId,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  ClassData.fromJson(Map<String, dynamic> json) {
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

class Section {
  int? id;
  String? sectionName;
  String? nickName;
  int? classId;
  int? groupId;
  int? mediumId;
  int? teacherId;
  int? dormitoryId;
  int? roomId;
  int? shiftId;
  int? studentCapacity;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Section(
      {this.id,
        this.sectionName,
        this.nickName,
        this.classId,
        this.groupId,
        this.mediumId,
        this.teacherId,
        this.dormitoryId,
        this.roomId,
        this.shiftId,
        this.studentCapacity,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
    nickName = json['nick_name'];
    classId = json['class_id'];
    groupId = json['group_id'];
    mediumId = json['medium_id'];
    teacherId = json['teacher_id'];
    dormitoryId = json['dormitory_id'];
    roomId = json['room_id'];
    shiftId = json['shift_id'];
    studentCapacity = json['student_capacity'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_name'] = sectionName;
    data['nick_name'] = nickName;
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['medium_id'] = mediumId;
    data['teacher_id'] = teacherId;
    data['dormitory_id'] = dormitoryId;
    data['room_id'] = roomId;
    data['shift_id'] = shiftId;
    data['student_capacity'] = studentCapacity;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Group {
  int? id;
  String? groupName;
  int? status;
  int? classId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Group(
      {this.id,
        this.groupName,
        this.status,
        this.classId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    status = json['status'];
    classId = json['class_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['status'] = status;
    data['class_id'] = classId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class StudentInfo {
  int? id;
  int? stuId;
  int? acHeadId;
  String? title;
  int? amount;
  String? feeDate;
  int? session;
  int? status;
  String? createdAt;
  String? updatedAt;

  StudentInfo(
      {this.id,
        this.stuId,
        this.acHeadId,
        this.title,
        this.amount,
        this.feeDate,
        this.session,
        this.status,
        this.createdAt,
        this.updatedAt});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stuId = json['stu_id'];
    acHeadId = json['ac_head_id'];
    title = json['title'];
    amount = json['amount'];
    feeDate = json['fee_date'];
    session = json['session'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stu_id'] = stuId;
    data['ac_head_id'] = acHeadId;
    data['title'] = title;
    data['amount'] = amount;
    data['fee_date'] = feeDate;
    data['session'] = session;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
