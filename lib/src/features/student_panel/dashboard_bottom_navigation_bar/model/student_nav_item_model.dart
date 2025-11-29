
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
    title: "Camera",
    img: Images.feeIc,
  ),
  StudentNavItemModel(
    title: "Notification",
    img: Images.paymentLedgerIc,
  ),
  StudentNavItemModel(
    title: "Profile",
    img: Images.studentProfileIc,
  ),

];