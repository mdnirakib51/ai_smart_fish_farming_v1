class StudentFeeModel {
  String? studentId;
  String? session;
  int? totalUnpaid;
  List<Fees>? fees;

  StudentFeeModel({this.studentId, this.session, this.totalUnpaid, this.fees});

  StudentFeeModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    session = json['session'];
    totalUnpaid = json['total_unpaid'];
    if (json['fees'] != null) {
      fees = <Fees>[];
      json['fees'].forEach((v) {
        fees!.add(Fees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['session'] = session;
    data['total_unpaid'] = totalUnpaid;
    if (fees != null) {
      data['fees'] = fees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fees {
  String? accountHead;
  int? amount;
  String? assignedMonth;
  int? paid;
  int? discount;
  int? due;
  String? status;

  Fees(
      {this.accountHead,
        this.amount,
        this.assignedMonth,
        this.paid,
        this.discount,
        this.due,
        this.status});

  Fees.fromJson(Map<String, dynamic> json) {
    accountHead = json['account_head'];
    amount = json['amount'];
    assignedMonth = json['assigned_month'];
    paid = json['paid'];
    discount = json['discount'];
    due = json['due'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_head'] = accountHead;
    data['amount'] = amount;
    data['assigned_month'] = assignedMonth;
    data['paid'] = paid;
    data['discount'] = discount;
    data['due'] = due;
    data['status'] = status;
    return data;
  }
}
