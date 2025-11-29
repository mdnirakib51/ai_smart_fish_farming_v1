class StudentExamResultModel {
  Organization? organization;
  Exam? exam;
  Student? student;
  ClassTeacher? classTeacher;
  MarksStructure? marksStructure;
  Subjects? subjects;
  Summary? summary;
  Position? position;
  List<GradingSystem>? gradingSystem;

  StudentExamResultModel(
      {this.organization,
        this.exam,
        this.student,
        this.classTeacher,
        this.marksStructure,
        this.subjects,
        this.summary,
        this.position,
        this.gradingSystem});

  StudentExamResultModel.fromJson(Map<String, dynamic> json) {
    organization = json['organization'] != null
        ? Organization.fromJson(json['organization'])
        : null;
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    classTeacher = json['class_teacher'] != null
        ? ClassTeacher.fromJson(json['class_teacher'])
        : null;
    marksStructure = json['marks_structure'] != null
        ? MarksStructure.fromJson(json['marks_structure'])
        : null;
    subjects = json['subjects'] != null
        ? Subjects.fromJson(json['subjects'])
        : null;
    summary =
    json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    position = json['position'] != null
        ? Position.fromJson(json['position'])
        : null;
    if (json['grading_system'] != null) {
      gradingSystem = <GradingSystem>[];
      json['grading_system'].forEach((v) {
        gradingSystem!.add(GradingSystem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (classTeacher != null) {
      data['class_teacher'] = classTeacher!.toJson();
    }
    if (marksStructure != null) {
      data['marks_structure'] = marksStructure!.toJson();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (position != null) {
      data['position'] = position!.toJson();
    }
    if (gradingSystem != null) {
      data['grading_system'] =
          gradingSystem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Organization {
  String? name;
  String? logo;

  Organization({this.name, this.logo});

  Organization.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}

class Exam {
  String? name;
  String? date;

  Exam({this.name, this.date});

  Exam.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['date'] = date;
    return data;
  }
}

class Student {
  String? name;
  int? roll;
  String? classs;
  String? section;
  String? group;
  String? shift;
  String? session;

  Student(
      {this.name,
        this.roll,
        this.classs,
        this.section,
        this.group,
        this.shift,
        this.session});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roll = json['roll'];
    classs = json['classs'];
    section = json['section'];
    group = json['group'];
    shift = json['shift'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['roll'] = roll;
    data['classs'] = classs;
    data['section'] = section;
    data['group'] = group;
    data['shift'] = shift;
    data['session'] = session;
    return data;
  }
}

class ClassTeacher {
  String? name;
  String? phone;

  ClassTeacher({this.name, this.phone});

  ClassTeacher.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}

class MarksStructure {
  int? writtenMarks;
  int? objectiveMarks;
  int? practicalMarks;
  int? ctMarks;
  int? sbaMarks;
  int? oralMarks;
  int? dairyMarks;
  int? continuousAssessment;

  MarksStructure(
      {this.writtenMarks,
        this.objectiveMarks,
        this.practicalMarks,
        this.ctMarks,
        this.sbaMarks,
        this.oralMarks,
        this.dairyMarks,
        this.continuousAssessment});

  MarksStructure.fromJson(Map<String, dynamic> json) {
    writtenMarks = json['written_marks'];
    objectiveMarks = json['objective_marks'];
    practicalMarks = json['practical_marks'];
    ctMarks = json['ct_marks'];
    sbaMarks = json['sba_marks'];
    oralMarks = json['oral_marks'];
    dairyMarks = json['dairy_marks'];
    continuousAssessment = json['continuous_assessment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['written_marks'] = writtenMarks;
    data['objective_marks'] = objectiveMarks;
    data['practical_marks'] = practicalMarks;
    data['ct_marks'] = ctMarks;
    data['sba_marks'] = sbaMarks;
    data['oral_marks'] = oralMarks;
    data['dairy_marks'] = dairyMarks;
    data['continuous_assessment'] = continuousAssessment;
    return data;
  }
}

class Subjects {
  List<Regular>? regular;
  List<Optional>? optional;
  List<ContinuousAssessment>? continuousAssessment;

  Subjects({this.regular, this.optional, this.continuousAssessment});

  Subjects.fromJson(Map<String, dynamic> json) {
    if (json['regular'] != null) {
      regular = <Regular>[];
      json['regular'].forEach((v) {
        regular!.add(Regular.fromJson(v));
      });
    }
    if (json['optional'] != null) {
      optional = <Optional>[];
      json['optional'].forEach((v) {
        optional!.add(Optional.fromJson(v));
      });
    }
    if (json['continuous_assessment'] != null) {
      continuousAssessment = <ContinuousAssessment>[];
      json['continuous_assessment'].forEach((v) {
        continuousAssessment!.add(ContinuousAssessment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (regular != null) {
      data['regular'] = regular!.map((v) => v.toJson()).toList();
    }
    if (optional != null) {
      data['optional'] = optional!.map((v) => v.toJson()).toList();
    }
    if (continuousAssessment != null) {
      data['continuous_assessment'] =
          continuousAssessment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regular {
  String? subjectName;
  int? fullMarks;
  int? written;
  int? objective;
  int? practical;
  int? ct;
  int? sba;
  int? oral;
  int? diary;
  int? totalMark;
  String? gradeName;
  double? gradePoint;
  int? highestMark;
  int? passStatus;

  Regular(
      {this.subjectName,
        this.fullMarks,
        this.written,
        this.objective,
        this.practical,
        this.ct,
        this.sba,
        this.oral,
        this.diary,
        this.totalMark,
        this.gradeName,
        this.gradePoint,
        this.highestMark,
        this.passStatus});

  Regular.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    fullMarks = json['full_marks'];
    written = json['written'];
    objective = json['objective'];
    practical = json['practical'];
    ct = json['ct'];
    sba = json['sba'];
    oral = json['oral'];
    diary = json['diary'];
    totalMark = json['total_mark'];
    gradeName = json['grade_name'];
    gradePoint = json['grade_point'].toDouble();
    highestMark = json['highest_mark'];
    passStatus = json['pass_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_name'] = subjectName;
    data['full_marks'] = fullMarks;
    data['written'] = written;
    data['objective'] = objective;
    data['practical'] = practical;
    data['ct'] = ct;
    data['sba'] = sba;
    data['oral'] = oral;
    data['diary'] = diary;
    data['total_mark'] = totalMark;
    data['grade_name'] = gradeName;
    data['grade_point'] = gradePoint;
    data['highest_mark'] = highestMark;
    data['pass_status'] = passStatus;
    return data;
  }
}

class Optional {
  String? subjectName;
  int? fullMarks;
  int? written;
  int? objective;
  int? practical;
  int? ct;
  int? sba;
  int? oral;
  int? diary;
  int? totalMark;
  String? gradeName;
  int? gradePoint;
  int? highestMark;
  int? passStatus;
  int? adjustedGradePoint;

  Optional(
      {this.subjectName,
        this.fullMarks,
        this.written,
        this.objective,
        this.practical,
        this.ct,
        this.sba,
        this.oral,
        this.diary,
        this.totalMark,
        this.gradeName,
        this.gradePoint,
        this.highestMark,
        this.passStatus,
        this.adjustedGradePoint});

  Optional.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    fullMarks = json['full_marks'];
    written = json['written'];
    objective = json['objective'];
    practical = json['practical'];
    ct = json['ct'];
    sba = json['sba'];
    oral = json['oral'];
    diary = json['diary'];
    totalMark = json['total_mark'];
    gradeName = json['grade_name'];
    gradePoint = json['grade_point'];
    highestMark = json['highest_mark'];
    passStatus = json['pass_status'];
    adjustedGradePoint = json['adjusted_grade_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_name'] = subjectName;
    data['full_marks'] = fullMarks;
    data['written'] = written;
    data['objective'] = objective;
    data['practical'] = practical;
    data['ct'] = ct;
    data['sba'] = sba;
    data['oral'] = oral;
    data['diary'] = diary;
    data['total_mark'] = totalMark;
    data['grade_name'] = gradeName;
    data['grade_point'] = gradePoint;
    data['highest_mark'] = highestMark;
    data['pass_status'] = passStatus;
    data['adjusted_grade_point'] = adjustedGradePoint;
    return data;
  }
}

class ContinuousAssessment {
  String? subjectName;
  int? fullMarks;
  int? written;
  int? objective;
  int? practical;
  int? ct;
  int? sba;
  int? oral;
  int? diary;
  int? totalMark;
  String? gradeName;
  int? gradePoint;
  int? highestMark;
  int? passStatus;

  ContinuousAssessment(
      {this.subjectName,
        this.fullMarks,
        this.written,
        this.objective,
        this.practical,
        this.ct,
        this.sba,
        this.oral,
        this.diary,
        this.totalMark,
        this.gradeName,
        this.gradePoint,
        this.highestMark,
        this.passStatus});

  ContinuousAssessment.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    fullMarks = json['full_marks'];
    written = json['written'];
    objective = json['objective'];
    practical = json['practical'];
    ct = json['ct'];
    sba = json['sba'];
    oral = json['oral'];
    diary = json['diary'];
    totalMark = json['total_mark'];
    gradeName = json['grade_name'];
    gradePoint = json['grade_point'];
    highestMark = json['highest_mark'];
    passStatus = json['pass_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_name'] = subjectName;
    data['full_marks'] = fullMarks;
    data['written'] = written;
    data['objective'] = objective;
    data['practical'] = practical;
    data['ct'] = ct;
    data['sba'] = sba;
    data['oral'] = oral;
    data['diary'] = diary;
    data['total_mark'] = totalMark;
    data['grade_name'] = gradeName;
    data['grade_point'] = gradePoint;
    data['highest_mark'] = highestMark;
    data['pass_status'] = passStatus;
    return data;
  }
}

class Summary {
  int? totalMarks;
  double? gpa;
  int? passStatus;
  int? continuousAssessmentGpa;
  int? continuousAssessmentTotal;

  Summary(
      {this.totalMarks,
        this.gpa,
        this.passStatus,
        this.continuousAssessmentGpa,
        this.continuousAssessmentTotal});

  Summary.fromJson(Map<String, dynamic> json) {
    totalMarks = json['total_marks'];
    gpa = json['gpa'].toDouble();
    passStatus = json['pass_status'];
    continuousAssessmentGpa = json['continuous_assessment_gpa'];
    continuousAssessmentTotal = json['continuous_assessment_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_marks'] = totalMarks;
    data['gpa'] = gpa;
    data['pass_status'] = passStatus;
    data['continuous_assessment_gpa'] = continuousAssessmentGpa;
    data['continuous_assessment_total'] = continuousAssessmentTotal;
    return data;
  }
}

class Position {
  int? sectionStudents;
  int? sectionPosition;
  int? classStudents;
  int? classPosition;

  Position(
      {this.sectionStudents,
        this.sectionPosition,
        this.classStudents,
        this.classPosition});

  Position.fromJson(Map<String, dynamic> json) {
    sectionStudents = json['section_students'];
    sectionPosition = json['section_position'];
    classStudents = json['class_students'];
    classPosition = json['class_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_students'] = sectionStudents;
    data['section_position'] = sectionPosition;
    data['class_students'] = classStudents;
    data['class_position'] = classPosition;
    return data;
  }
}

class GradingSystem {
  String? grade;
  String? marks100;
  String? marks50;
  String? point;

  GradingSystem({this.grade, this.marks100, this.marks50, this.point});

  GradingSystem.fromJson(Map<String, dynamic> json) {
    grade = json['grade'];
    marks100 = json['marks_100'];
    marks50 = json['marks_50'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grade'] = grade;
    data['marks_100'] = marks100;
    data['marks_50'] = marks50;
    data['point'] = point;
    return data;
  }
}
