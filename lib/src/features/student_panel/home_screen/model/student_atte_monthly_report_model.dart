class StudentAtteMonthlyReportModel {
  Student? student;
  String? month;
  SummaryMonthlyModel? summary;
  List<AttendanceMonthModel>? attendance;

  StudentAtteMonthlyReportModel(
      {this.student, this.month, this.summary, this.attendance});

  StudentAtteMonthlyReportModel.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    month = json['month'];
    summary =
    json['summary'] != null ? SummaryMonthlyModel.fromJson(json['summary']) : null;
    if (json['attendance'] != null) {
      attendance = <AttendanceMonthModel>[];
      json['attendance'].forEach((v) {
        attendance!.add(AttendanceMonthModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    data['month'] = month;
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  String? id;
  String? name;
  int? roll;
  String? className;
  String? section;

  Student({this.id, this.name, this.roll, this.className, this.section});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    roll = json['roll'];
    className = json['class'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['roll'] = roll;
    data['class'] = className;
    data['section'] = section;
    return data;
  }
}

class SummaryMonthlyModel {
  int? present;
  int? late;
  int? absent;

  SummaryMonthlyModel({this.present, this.late, this.absent});

  SummaryMonthlyModel.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    late = json['late'];
    absent = json['absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present'] = present;
    data['late'] = late;
    data['absent'] = absent;
    return data;
  }
}

class AttendanceMonthModel {
  String? date;
  int? day;
  String? status;

  AttendanceMonthModel({this.date, this.day, this.status});

  AttendanceMonthModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['status'] = status;
    return data;
  }
}
