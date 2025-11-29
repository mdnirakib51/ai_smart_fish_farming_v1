class StudentLedgerModel {
  Student? student;
  String? session;
  List<InitialFees>? initialFees;
  List<PaidFees>? paidFees;
  List<UnpaidFees>? unpaidFees;
  List<Discounts>? discounts;
  Totals? totals;

  StudentLedgerModel(
      {this.student,
        this.session,
        this.initialFees,
        this.paidFees,
        this.discounts,
        this.totals});

  StudentLedgerModel.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    session = json['session'];
    if (json['initial_fees'] != null) {
      initialFees = <InitialFees>[];
      json['initial_fees'].forEach((v) {
        initialFees!.add(InitialFees.fromJson(v));
      });
    }
    if (json['paid_fees'] != null) {
      paidFees = <PaidFees>[];
      json['paid_fees'].forEach((v) {
        paidFees!.add(PaidFees.fromJson(v));
      });
    }
    if (json['unpaid_fees'] != null) {
      unpaidFees = <UnpaidFees>[];
      json['unpaid_fees'].forEach((v) {
        unpaidFees!.add(UnpaidFees.fromJson(v));
      });
    }
    if (json['discounts'] != null) {
      discounts = <Discounts>[];
      json['discounts'].forEach((v) {
        discounts!.add(Discounts.fromJson(v));
      });
    }
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    data['session'] = session;
    if (initialFees != null) {
      data['initial_fees'] = initialFees!.map((v) => v.toJson()).toList();
    }
    if (paidFees != null) {
      data['paid_fees'] = paidFees!.map((v) => v.toJson()).toList();
    }
    if (discounts != null) {
      data['discounts'] = discounts!.map((v) => v.toJson()).toList();
    }
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? name;
  String? uniqueId;

  Student({this.id, this.name, this.uniqueId});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uniqueId = json['unique_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['unique_id'] = uniqueId;
    return data;
  }
}

class InitialFees {
  int? id;
  String? date;
  String? feeMonth;
  String? accountHead;
  int? amount;

  InitialFees(
      {this.id, this.date, this.feeMonth, this.accountHead, this.amount});

  InitialFees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    feeMonth = json['fee_month'];
    accountHead = json['account_head'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['fee_month'] = feeMonth;
    data['account_head'] = accountHead;
    data['amount'] = amount;
    return data;
  }
}

class PaidFees {
  int? id;
  String? paidDate;
  String? feeMonth;
  String? accountHead;
  int? amount;

  PaidFees(
      {this.id, this.paidDate, this.feeMonth, this.accountHead, this.amount});

  PaidFees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paidDate = json['paid_date'];
    feeMonth = json['fee_month'];
    accountHead = json['account_head'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paid_date'] = paidDate;
    data['fee_month'] = feeMonth;
    data['account_head'] = accountHead;
    data['amount'] = amount;
    return data;
  }
}

class Discounts {
  int? id;
  String? discountDate;
  String? accountHead;
  int? amount;
  String? note;

  Discounts(
      {this.id, this.discountDate, this.accountHead, this.amount, this.note});

  Discounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountDate = json['discount_date'];
    accountHead = json['account_head'];
    amount = json['amount'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['discount_date'] = discountDate;
    data['account_head'] = accountHead;
    data['amount'] = amount;
    data['note'] = note;
    return data;
  }
}

class UnpaidFees {
  int? id;
  String? date;
  String? feeMonth;
  String? accountHead;
  int? amount;

  UnpaidFees(
      {this.id, this.date, this.feeMonth, this.accountHead, this.amount});

  UnpaidFees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    feeMonth = json['fee_month'];
    accountHead = json['account_head'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['fee_month'] = feeMonth;
    data['account_head'] = accountHead;
    data['amount'] = amount;
    return data;
  }
}


class Totals {
  int? totalInitial;
  int? totalPaid;
  int? totalDiscount;
  int? totalDue;

  Totals(
      {this.totalInitial, this.totalPaid, this.totalDiscount, this.totalDue});

  Totals.fromJson(Map<String, dynamic> json) {
    totalInitial = json['total_initial'];
    totalPaid = json['total_paid'];
    totalDiscount = json['total_discount'];
    totalDue = json['total_due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_initial'] = totalInitial;
    data['total_paid'] = totalPaid;
    data['total_discount'] = totalDiscount;
    data['total_due'] = totalDue;
    return data;
  }
}
