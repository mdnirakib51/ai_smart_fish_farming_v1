
import '../../../../domain/server/http_client/api_helper.dart';
import '../../../../domain/server/http_client/app_config.dart';
import '../model/student_fee_model.dart';
import '../model/student_ledger_model.dart';

class StudentFeeRepository extends ApiHelper {

  Future<StudentFeeModel> getStudentsFeeList() async {
    final response = await requestHandler.getWrp(AppConfig.studentFeeListUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentFeeModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

  Future<StudentLedgerModel> getStudentsLedgerList() async {
    final response = await requestHandler.getWrp(AppConfig.studentLedgerUrl.url);
    if(response.code == 200 || response.code == 201){
      return StudentLedgerModel.fromJson(response.data ?? {});
    }
    throw Exception('Response failed with code ${response.code}: ${response.message}');
  }

}

