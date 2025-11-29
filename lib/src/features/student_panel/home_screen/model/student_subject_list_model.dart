class StudentSubjectListModel {
  StudentDetails? studentDetails;
  List<Subjects>? subjects;

  StudentSubjectListModel({this.studentDetails, this.subjects});

  StudentSubjectListModel.fromJson(Map<String, dynamic> json) {
    studentDetails = json['student_details'] != null
        ? StudentDetails.fromJson(json['student_details'])
        : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentDetails != null) {
      data['student_details'] = studentDetails!.toJson();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDetails {
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
  Group? group;
  Section? section;
  ClassData? classData;

  StudentDetails(
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
        this.group,
        this.section,
        this.classData});

  StudentDetails.fromJson(Map<String, dynamic> json) {
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
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    section =
    json['section'] != null ? Section.fromJson(json['section']) : null;
    classData =
    json['class'] != null ? ClassData.fromJson(json['class']) : null;
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
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (classData != null) {
      data['class'] = classData!.toJson();
    }
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

class Subjects {
  int? id;
  String? subjectName;
  String? teacherName;

  Subjects({this.id, this.subjectName, this.teacherName});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    teacherName = json['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['teacher_name'] = teacherName;
    return data;
  }
}
