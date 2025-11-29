
import '../../../../global/constants/images.dart';

class StudentNavItemModel{
  final String title;
  final String img;

  StudentNavItemModel({
    required this.title,
    required this.img
  });
}

List<StudentNavItemModel> studnetNavItemList = [
  StudentNavItemModel(
    title: "Home",
    img: Images.homeIc,
  ),
  StudentNavItemModel(
    title: "Fee",
    img: Images.feeIc,
  ),
  StudentNavItemModel(
    title: "Payment Ledger",
    img: Images.paymentLedgerIc,
  ),
  StudentNavItemModel(
    title: "Profile",
    img: Images.studentProfileIc,
  ),

];