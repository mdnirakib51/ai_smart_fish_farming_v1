class StudentExamModel {
  Student? student;
  List<Exams>? exams;

  StudentExamModel({this.student, this.exams});

  StudentExamModel.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(Exams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (exams != null) {
      data['exams'] = exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  String? name;
  int? roll;
  String? className;
  String? section;
  String? group;

  Student({this.name, this.roll, this.className, this.section, this.group});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roll = json['roll'];
    className = json['class'];
    section = json['section'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['roll'] = roll;
    data['class'] = className;
    data['section'] = section;
    data['group'] = group;
    return data;
  }
}

class Exams {
  int? id;
  String? examName;
  String? examDate;
  int? resultStatus;

  Exams({this.id, this.examName, this.examDate, this.resultStatus});

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examName = json['exam_name'];
    examDate = json['exam_date'];
    resultStatus = json['result_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exam_name'] = examName;
    data['exam_date'] = examDate;
    data['result_status'] = resultStatus;
    return data;
  }
}
