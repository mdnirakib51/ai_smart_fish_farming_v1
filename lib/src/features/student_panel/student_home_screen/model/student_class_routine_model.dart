class StudentClassRoutineModel {
  Student? student;
  List<PeriodsInfo>? periodsInfo;
  List<Routine>? routine;

  StudentClassRoutineModel({this.student, this.periodsInfo, this.routine});

  StudentClassRoutineModel.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    if (json['periods_info'] != null) {
      periodsInfo = <PeriodsInfo>[];
      json['periods_info'].forEach((v) {
        periodsInfo!.add(PeriodsInfo.fromJson(v));
      });
    }
    if (json['routine'] != null) {
      routine = <Routine>[];
      json['routine'].forEach((v) {
        routine!.add(Routine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (periodsInfo != null) {
      data['periods_info'] = periodsInfo!.map((v) => v.toJson()).toList();
    }
    if (routine != null) {
      data['routine'] = routine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  String? id;
  String? name;
  String? classData;
  String? section;

  Student({this.id, this.name, this.classData, this.section});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    classData = json['class'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['class'] = classData;
    data['section'] = section;
    return data;
  }
}

class PeriodsInfo {
  int? id;
  String? periodName;
  String? startTime;
  String? endTime;
  String? timeRange;

  PeriodsInfo(
      {this.id, this.periodName, this.startTime, this.endTime, this.timeRange});

  PeriodsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    periodName = json['period_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    timeRange = json['time_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['period_name'] = periodName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['time_range'] = timeRange;
    return data;
  }
}

class Routine {
  String? day;
  bool? isHoliday;
  List<Periods>? periods;
  String? holidayMessage; // Add this to store holiday message

  Routine({this.day, this.isHoliday, this.periods, this.holidayMessage});

  Routine.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    isHoliday = json['is_holiday'];

    // Handle periods field - it can be either a List or a String
    if (json['periods'] != null) {
      if (json['periods'] is List) {
        // Normal case - periods is a list of period objects
        periods = <Periods>[];
        json['periods'].forEach((v) {
          periods!.add(Periods.fromJson(v));
        });
      } else if (json['periods'] is String) {
        // Holiday case - periods is a string like "Holiday"
        holidayMessage = json['periods'];
        periods = null; // Set periods to null for holidays
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['is_holiday'] = isHoliday;

    // Handle periods field for toJson
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    } else if (holidayMessage != null) {
      data['periods'] = holidayMessage;
    }

    return data;
  }
}

class Periods {
  int? periodId;
  String? periodName;
  String? startTime;
  String? endTime;
  String? timeRange;
  String? subjectName;
  Teacher? teacher;

  Periods(
      {this.periodId,
        this.periodName,
        this.startTime,
        this.endTime,
        this.timeRange,
        this.subjectName,
        this.teacher});

  Periods.fromJson(Map<String, dynamic> json) {
    periodId = json['period_id'];
    periodName = json['period_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    timeRange = json['time_range'];
    subjectName = json['subject_name'];
    teacher =
    json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_id'] = periodId;
    data['period_name'] = periodName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['time_range'] = timeRange;
    data['subject_name'] = subjectName;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? name;
  String? photo;

  Teacher({this.id, this.name, this.photo});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    return data;
  }
}
