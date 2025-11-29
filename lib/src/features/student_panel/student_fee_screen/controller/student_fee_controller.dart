
import 'dart:developer';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/features/student_panel/student_fee_screen/controller/student_fee_repo.dart';
import '../model/student_fee_model.dart';
import '../model/student_ledger_model.dart';

class StudentFeeController extends GetxController implements GetxService {
  static StudentFeeController get current => Get.find();
  final StudentFeeRepository repository = StudentFeeRepository();
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

  StudentFeeModel? studentFeeModel;
  Future getStudentsFeeList() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentsFeeList();

      studentFeeModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

  // Fee Calculation Methods

  /// Get total assigned amount from all fees
  int get totalAssignedAmount {
    if (studentFeeModel?.fees == null) return 0;

    int total = 0;
    for (var fee in studentFeeModel!.fees!) {
      total += (fee.amount ?? 0);
    }
    return total;
  }

  /// Get total paid amount from all fees
  int get totalPaidAmount {
    if (studentFeeModel?.fees == null) return 0;

    int total = 0;
    for (var fee in studentFeeModel!.fees!) {
      total += (fee.paid ?? 0);
    }
    return total;
  }

  /// Get total pending amount (assigned - paid)
  int get totalPendingAmount {
    return totalAssignedAmount - totalPaidAmount;
  }

  /// Get total discount amount
  int get totalDiscountAmount {
    if (studentFeeModel?.fees == null) return 0;

    int total = 0;
    for (var fee in studentFeeModel!.fees!) {
      total += (fee.discount ?? 0);
    }
    return total;
  }

  /// Get total due amount from all unpaid fees
  int get totalDueAmount {
    if (studentFeeModel?.fees == null) return 0;

    int total = 0;
    for (var fee in studentFeeModel!.fees!) {
      if (fee.status?.toLowerCase() == 'unpaid') {
        total += (fee.due ?? 0);
      }
    }
    return total;
  }

  /// Get count of unpaid fee items
  int get unpaidFeeCount {
    if (studentFeeModel?.fees == null) return 0;

    int count = 0;
    for (var fee in (studentFeeModel?.fees ?? [])) {
      if (fee.status?.toLowerCase() == 'unpaid') {
        count++;
      }
    }
    return count;
  }

  /// Get count of paid fee items
  int get paidFeeCount {
    if (studentFeeModel?.fees == null) return 0;

    int count = 0;
    for (var fee in (studentFeeModel?.fees ?? [])) {
      if (fee.status?.toLowerCase() == 'paid') {
        count++;
      }
    }
    return count;
  }

  /// Get list of only unpaid fees
  List<Fees> get unpaidFees {
    if (studentFeeModel?.fees == null) return [];

    return studentFeeModel?.fees?.where((fee) => fee.status?.toLowerCase() == 'unpaid').toList() ?? [];
  }

  /// Get list of only paid fees
  List<Fees> get paidFees {
    if (studentFeeModel?.fees == null) return [];

    return studentFeeModel!.fees!
        .where((fee) => fee.status?.toLowerCase() == 'paid')
        .toList();
  }

  /// Check if a specific fee is paid
  bool isFeePaid(Fees fee) {
    return fee.status?.toLowerCase() == 'paid';
  }

  /// Get remaining amount for a specific fee
  int getRemainingAmount(Fees fee) {
    if (isFeePaid(fee)) return 0;
    return (fee.due ?? 0);
  }

  /// Get session year from fee model
  String get currentSession {
    return studentFeeModel?.session ?? "2025";
  }

  /// Get student ID
  String get currentStudentId {
    return studentFeeModel?.studentId ?? "";
  }

  /// Format amount with Taka symbol
  String formatAmount(int amount) {
    return '৳$amount';
  }

  /// Get summary data as Map for easy access
  Map<String, dynamic> get feeSummary {
    return {
      'totalAssigned': totalAssignedAmount,
      'totalPaid': totalPaidAmount,
      'totalPending': totalPendingAmount,
      'totalDiscount': totalDiscountAmount,
      'totalDue': totalDueAmount,
      'unpaidCount': unpaidFeeCount,
      'paidCount': paidFeeCount,
      'session': currentSession,
      'studentId': currentStudentId,
    };
  }

  /// Get formatted summary for display
  Map<String, String> get formattedFeeSummary {
    return {
      'totalAssigned': formatAmount(totalAssignedAmount),
      'totalPaid': formatAmount(totalPaidAmount),
      'totalPending': formatAmount(totalPendingAmount),
      'totalDiscount': formatAmount(totalDiscountAmount),
      'totalDue': formatAmount(totalDueAmount),
      'unpaidCount': unpaidFeeCount.toString(),
      'paidCount': paidFeeCount.toString(),
      'session': currentSession,
      'studentId': currentStudentId,
    };
  }


  /// =============/@ Student Ledger @/ ==================

  StudentLedgerModel? studentLedgerModel;
  Future getStudentsLedgerList() async {
    try {
      _setLoadingState(true);

      final response = await repository.getStudentsLedgerList();

      studentLedgerModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }

}
