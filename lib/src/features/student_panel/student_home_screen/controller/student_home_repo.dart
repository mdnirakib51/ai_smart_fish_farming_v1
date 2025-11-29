
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../../domain/server/http_client/api_helper.dart';
import '../../../../domain/server/http_client/app_config.dart';
import '../../../../service/auth/model/auth_model.dart';
import '../model/student_atte_monthly_report_model.dart';
import '../model/student_class_routine_model.dart';
import '../model/student_class_teacher_model.dart';
import '../model/student_content_model.dart';
import '../model/student_exam_model.dart';
import '../model/student_exam_result_model.dart';
import '../model/student_exam_routine_model.dart';
import '../model/student_library_model.dart';
import '../model/student_notice_model.dart';
import '../model/student_profile_view_model.dart';
import '../model/student_subject_list_model.dart';

class StudentHomeRepository extends ApiHelper {

  Future<StudentProfileModel> getStudentsProfileView() async {
    final response = await requestHandler.getWrp(AppConfig.studentDashboardUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentProfileModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<AuthModel> reqUpdateProfile({
    required String name,
    required String email,
    String? phone,
    String? bloodGroup,
    String? birthdate,
    String? fatherName,
    String? motherName,
    String? address,
    String? permanentAddress,
    String? houseNo,
    String? roadNo,
    String? password,
    XFile? imagePath,
  }) async {

    MultipartFile? imagePathMul = imagePath != null ? await MultipartFile.fromFile(imagePath.path) : null;

    Map<String, dynamic> params = {};
    params['name'] = name;
    params['email'] = email;
    if (phone != null && phone.isNotEmpty) params['phone'] = phone;
    if (bloodGroup != null && bloodGroup.isNotEmpty) params['blood_group'] = bloodGroup;
    if (birthdate != null && birthdate.isNotEmpty) params['birthdate'] = birthdate;
    if (fatherName != null && fatherName.isNotEmpty) params['father_name'] = fatherName;
    if (motherName != null && motherName.isNotEmpty) params['mother_name'] = motherName;
    if (address != null && address.isNotEmpty) params['address'] = address;
    if (permanentAddress != null && permanentAddress.isNotEmpty) params['permanent_address'] = permanentAddress;
    if (houseNo != null && houseNo.isNotEmpty) params['house_no'] = houseNo;
    if (roadNo != null && roadNo.isNotEmpty) params['road_no'] = roadNo;
    if (password != null && password.isNotEmpty) params['password'] = password;
    if (imagePath != null) {
      params['photo'] = imagePathMul;
    }

    final response = await requestHandler.postWrp(AppConfig.studentUpdateUrl.url, params, isFormData: true);

    if(response.code == 200 || response.code == 201){
      return AuthModel.fromJson(response.data ?? {});
    }

    throw Exception('Profile update failed with code ${response.code}: ${response.message}');
  }

  Future<AuthModel> reqChangePassword({
    required String confirmPassword,
  }) async {

    Map<String, dynamic> params = {};
    params['confirm_password'] = confirmPassword;

    final response = await requestHandler.postWrp(AppConfig.studentChangePasswordUrl.url, params, isFormData: true);
    if(response.code == 200 || response.code == 201){
      return AuthModel.fromJson(response.data ?? {});
    }

    throw Exception('Profile update failed with code ${response.code}: ${response.message}');
  }

  Future<List<StudentNoticeModel>> getStudentsNotice() async {
    final response = await requestHandler.getWrp(AppConfig.studentNoticeUrl.url);
    if(response.code == 200 || response.code == 201){
      if (response.data is List) {
        return (response.data as List).map((jsonData) => StudentNoticeModel.fromJson(jsonData)).toList();
      } else {
        return [];
      }
    }

    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentAtteMonthlyReportModel> getStudentsAtteMonthlyReport({
    required String? month
  }) async {
    Map<String, dynamic> params = {};
    params['month'] = month;

    final response = await requestHandler.getWrp(AppConfig.studentAttendanceUrl.url, queryParams: params);
    if(response.code == 200 || response.code == 201){
      return StudentAtteMonthlyReportModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentSubjectListModel> getStudentSubjectList() async {
    final response = await requestHandler.getWrp(AppConfig.studentSubjectUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentSubjectListModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentClassTeacherModel> getStudentClassTeacher() async {
    final response = await requestHandler.getWrp(AppConfig.studentClassTeacherUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentClassTeacherModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<List<StudentLibraryModel>> getStudentLibraryList() async {
    final response = await requestHandler.getWrp(AppConfig.studentLibraryListUrl.url);
    if(response.code == 200 || response.code == 201){
      if (response.data is List) {
        return (response.data as List).map((jsonData) => StudentLibraryModel.fromJson(jsonData)).toList();
      } else {
        return [];
      }
    }

    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentClassRoutineModel> getStudentClassSchedule() async {
    final response = await requestHandler.getWrp(AppConfig.studentClassRoutineUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentClassRoutineModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentExamResultModel> getStudentExamResult({
    required int? examResultId,
  }) async {

    final response = await requestHandler.getWrp("${AppConfig.studentExamResultUrl.url}/$examResultId");
    if(response.code == 200 || response.code == 201){
      return StudentExamResultModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentExamModel> getStudentExam() async {
    final response = await requestHandler.getWrp(AppConfig.studentExamUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentExamModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentExamRoutineModel> getStudentExamRoutine() async {
    final response = await requestHandler.getWrp(AppConfig.studentExamRoutineUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentExamRoutineModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentContentModel> getStudentContent() async {
    final response =  await requestHandler.getWrp(AppConfig.studentContentUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentContentModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }


}

