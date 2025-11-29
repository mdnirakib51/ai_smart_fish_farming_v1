import 'dart:developer';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
import 'student_home_repo.dart';

class HomePageController extends GetxController implements GetxService {
  static HomePageController get current => Get.find();
  final StudentHomeRepository repository = StudentHomeRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasError = false;

  bool get hasError => _hasError;

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    _hasError = false;
    update();
  }

  void _setErrorState(bool hasError) {
    _isLoading = false;
    _hasError = hasError;
    update();
  }

  StudentProfileModel? studentProfileModel;
  Future getStudentsProfileView() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentsProfileView();

      studentProfileModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  AuthModel? authModel;
  Future reqUpdateProfile({
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
    try {
      _setLoadingState(true);

      final response = await repository.reqUpdateProfile(
        name: name,
        email: email,
        phone: phone,
        bloodGroup: bloodGroup,
        birthdate: birthdate,
        fatherName: fatherName,
        motherName: motherName,
        address: address,
        permanentAddress: permanentAddress,
        houseNo: houseNo,
        roadNo: roadNo,
        password: password,
        imagePath: imagePath,
      );

      authModel = response;

      await getStudentsProfileView();

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
      rethrow;
    }
  }


  List<StudentNoticeModel>? studentNoticeModel;
  Future getStudentsNotice() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentsNotice();

      studentNoticeModel = response.reversed.toList();

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  Future reqChangePassword({
    required String confirmPassword,
    required Function onChange,
  }) async {
    try {
      _setLoadingState(true);

      final response = await repository.reqChangePassword(
        confirmPassword: confirmPassword,
      );
      authModel = response;
      await getStudentsProfileView();

      onChange();
      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentAtteMonthlyReportModel? studentAtteMonthlyReportModel;
  Future getStudentsAtteMonthlyReport({
    required String? month
  }) async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentsAtteMonthlyReport(month: month);
      studentAtteMonthlyReportModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentSubjectListModel? studentSubjectList;
  Future getStudentSubjectList() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentSubjectList();
      studentSubjectList = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentClassTeacherModel? studentClassTeacherModel;
  Future getStudentClassTeacher() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentClassTeacher();
      studentClassTeacherModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  List<StudentLibraryModel>? studentLibraryModel;
  Future getStudentLibraryList() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentLibraryList();

      studentLibraryModel = response.reversed.toList();

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentClassRoutineModel? studentClassRoutineModel;
  Future getStudentClassSchedule() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentClassSchedule();
      studentClassRoutineModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentExamResultModel? studentExamResultModel;
  Future getStudentExamResult({
    required int? examResultId,
  }) async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentExamResult(examResultId: examResultId);
      studentExamResultModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentExamModel? studentExamModel;
  Future getStudentExam() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentExam();
      studentExamModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentExamRoutineModel? studentExamRoutineModel;
  Future getStudentExamRoutine() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentExamRoutine();
      studentExamRoutineModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  StudentContentModel? studentContentModel;
  Future getStudentContent() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentContent();
      studentContentModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

}
