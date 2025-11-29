import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/constants/input_decoration.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_search_text_formfield.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_textform_field.dart';
import '../student_home_screen/controller/student_home_controller.dart';

class StudentApplyLeaveScreen extends StatefulWidget {
  const StudentApplyLeaveScreen({super.key});

  @override
  State<StudentApplyLeaveScreen> createState() => _StudentApplyLeaveScreenState();
}

class _StudentApplyLeaveScreenState extends State<StudentApplyLeaveScreen> {
  final TextEditingController applyDateCon = TextEditingController();
  final TextEditingController fromDateCon = TextEditingController();
  final TextEditingController toDateCon = TextEditingController();
  final TextEditingController applicationDayCon = TextEditingController();
  final TextEditingController reasonCon = TextEditingController();
  final TextEditingController addressDuringLeavePeriodCon = TextEditingController();
  final TextEditingController selectFileCon = TextEditingController();

  String? selectLeaveType;
  final List<String> itemsLeaveType = ["Personal Issue", "Govt", "Annual"];

  String? selectDayType;
  final List<String> itemsDayType = ["Full Day", "Half Day (1st Half)", "Half Day (2nd Half)"];

  PlatformFile? selectedPdf;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Apply Leave",
          expandedHeight: 60,
        ),
        slivers: [
          sliverSizedBoxH(20),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  GlobalSearchTextFormField(
                    text: "Select Leave Type",
                    color: ColorRes.grey,
                    item: itemsLeaveType,
                    onSelect: (val) {
                      setState(() {
                        selectLeaveType = val;
                      });
                    },
                  ),
                  sizedBoxH(15),
                  GlobalSearchTextFormField(
                    text: "Select Leave Type",
                    color: ColorRes.grey,
                    item: itemsDayType,
                    onSelect: (val) {
                      setState(() {
                        selectDayType = val;
                      });
                    },
                  ),

                  sizedBoxH(15),
                  GlobalTextFormField(
                    controller: applyDateCon,
                    labelText: 'Apply Date',
                    hintText: 'Apply Date',
                    keyboardType: TextInputType.datetime,
                    sufixIcon: Icon(Icons.today_outlined),
                    decoration: borderDecoration,
                    isDense: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  sizedBoxH(15),
                  GlobalTextFormField(
                    controller: fromDateCon,
                    labelText: 'From Date',
                    hintText: 'From Date',
                    keyboardType: TextInputType.datetime,
                    sufixIcon: Icon(Icons.calendar_month_outlined),
                    decoration: borderDecoration,
                    isDense: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  sizedBoxH(15),
                  GlobalTextFormField(
                    controller: toDateCon,
                    labelText: 'To Date',
                    hintText: 'To Date',
                    keyboardType: TextInputType.datetime,
                    sufixIcon: Icon(Icons.calendar_month_outlined),
                    decoration: borderDecoration,
                    isDense: true,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  sizedBoxH(15),
                  GlobalTextFormField(
                    controller: applicationDayCon,
                    labelText: 'Total Day',
                    hintText: 'Total Day',
                    keyboardType: TextInputType.number,
                    sufixIcon: Icon(Icons.calendar_view_day),
                    decoration: borderDecoration,
                    isDense: true,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  sizedBoxH(15),
                  GlobalTextFormField(
                    controller: reasonCon,
                    labelText: 'Reason',
                    hintText: 'Write Your Leave Reason',
                    sufixIcon: Icon(Icons.comment_outlined,),
                    decoration: borderDecoration,
                    isDense: true,
                    maxLines: 3,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  sizedBoxH(15),
                  GlobalTextFormField(
                    controller: addressDuringLeavePeriodCon,
                    labelText: 'Address During Leave Period',
                    hintText: 'Write Your Address During Leave Period',
                    sufixIcon: Icon(Icons.location_on_outlined),
                    decoration: borderDecoration,
                    isDense: true,
                    maxLines: 2,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  sizedBoxH(15),
                  GlobalButtonWidget(
                    str: 'Upload Document',
                    height: 45,
                    img: Images.uploadIc,
                    imgColor: ColorRes.grey,
                    borderColor: ColorRes.grey,
                    textColor: ColorRes.grey,
                    buttomColor: ColorRes.white,
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );

                      if (result != null && result.files.single.path != null) {
                        final pdfFile = result.files.single;
                        log("PDF Name: ${pdfFile.name}");
                        log("PDF Path: ${pdfFile.path}");

                        // Optional: save to a variable or upload
                        setState(() {
                          selectedPdf = pdfFile;
                        });
                      } else {
                        log("User canceled the picker");
                      }
                    },
                  ),
                  sizedBoxH(30),
                  GlobalButtonWidget(
                    str: 'Apply',
                    height: 45,
                    onTap: () {
                      // Add your update logic here
                    },
                  ),
                ],
              ),
            ),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }
}