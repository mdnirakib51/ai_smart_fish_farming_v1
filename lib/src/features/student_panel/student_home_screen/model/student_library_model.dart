class StudentLibraryModel {
  int? invoice;
  String? bookName;
  String? status;
  String? issuedDate;
  String? returnDate;

  StudentLibraryModel(
      {this.invoice,
        this.bookName,
        this.status,
        this.issuedDate,
        this.returnDate});

  StudentLibraryModel.fromJson(Map<String, dynamic> json) {
    invoice = json['invoice'];
    bookName = json['book_name'];
    status = json['status'];
    issuedDate = json['issued_date'];
    returnDate = json['return_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice'] = invoice;
    data['book_name'] = bookName;
    data['status'] = status;
    data['issued_date'] = issuedDate;
    data['return_date'] = returnDate;
    return data;
  }
}
