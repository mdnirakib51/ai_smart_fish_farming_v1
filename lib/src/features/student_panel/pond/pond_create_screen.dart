
import 'package:ai_smart_fish_farming/src/global/widget/global_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/input_decoration.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/utils/show_toast.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_search_text_formfield.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_textform_field.dart';
import '../../../service/auth/controller/auth_controller.dart';

class PondCreateScreen extends StatefulWidget {
  const PondCreateScreen({super.key});

  @override
  State<PondCreateScreen> createState() => _PondCreateScreenState();
}

class _PondCreateScreenState extends State<PondCreateScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  // Text Controllers
  final TextEditingController pondNameCon = TextEditingController();
  final TextEditingController pondLocCon = TextEditingController();
  final TextEditingController sizeCon = TextEditingController();
  final TextEditingController depthCon = TextEditingController();
  final TextEditingController upazilaCon = TextEditingController();
  final TextEditingController districtCon = TextEditingController();
  final TextEditingController unionCon = TextEditingController();
  final TextEditingController fishNameCon = TextEditingController();

  // Dropdown Lists
  final List<String> upazilaList = [
    "Dhamrai",
    "Dohar",
    "Keraniganj",
    "Nawabganj",
    "Savar"
  ];

  final List<String> districtList = [
    "Dhaka",
    "Chittagong",
    "Rajshahi",
    "Khulna",
    "Barisal",
    "Sylhet",
    "Rangpur",
    "Mymensingh"
  ];

  final List<String> unionList = [
    "Union 1",
    "Union 2",
    "Union 3",
    "Union 4",
    "Union 5"
  ];

  String? selectedUpazila;
  String? selectedDistrict;
  String? selectedUnion;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pondNameCon.dispose();
    pondLocCon.dispose();
    sizeCon.dispose();
    depthCon.dispose();
    upazilaCon.dispose();
    districtCon.dispose();
    unionCon.dispose();
    fishNameCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return CustomScrollViewWidget(
        scaffoldKey: drawerKey,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Add Pond",
          expandedHeight: 60,
        ),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                child: Column(
                  children: [
                    sizedBoxH(10),

                    // First Row - Pond Name & Pond Loc
                    Row(
                      children: [
                        Expanded(
                          child: GlobalTextFormField(
                            controller: pondNameCon,
                            titleText: "Pond Name",
                            hintText: "Enter pond name",
                            decoration: borderDecoration,
                            isDense: true,
                            isRequired: true,
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: GlobalTextFormField(
                            controller: pondLocCon,
                            titleText: "Pond Loc",
                            hintText: "Enter pond location",
                            decoration: borderDecoration,
                            isDense: true,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),

                    sizedBoxH(5),

                    // Second Row - Size & Depth
                    Row(
                      children: [
                        Expanded(
                          child: GlobalTextFormField(
                            controller: sizeCon,
                            titleText: "Size",
                            hintText: "Enter pond size",
                            decoration: borderDecoration,
                            isDense: true,
                            keyboardType: TextInputType.number,
                            isRequired: true,
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: GlobalTextFormField(
                            controller: depthCon,
                            titleText: "Depth",
                            hintText: "Enter pond depth",
                            decoration: borderDecoration,
                            isDense: true,
                            keyboardType: TextInputType.number,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),

                    sizedBoxH(5),

                    // Third Row - Upazila & District
                    Row(
                      children: [
                        Expanded(
                          child: GlobalSearchTextFormField(
                            titleText: "Upazila",
                            text: selectedUpazila ?? "",
                            color: ColorRes.black,
                            item: upazilaList,
                            isRequired: true,
                            onSelect: (val) async {
                              setState(() {
                                selectedUpazila = val;
                                upazilaCon.text = val;
                              });
                            },
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: GlobalSearchTextFormField(
                            titleText: "District",
                            text: selectedDistrict ?? "",
                            color: ColorRes.black,
                            item: districtList,
                            isRequired: true,
                            onSelect: (val) async {
                              setState(() {
                                selectedDistrict = val;
                                districtCon.text = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    sizedBoxH(5),

                    // Fourth Row - Union & Map Integration
                    Row(
                      children: [
                        Expanded(
                          child: GlobalSearchTextFormField(
                            titleText: "Union",
                            text: selectedUnion ?? "",
                            color: ColorRes.black,
                            item: unionList,
                            isRequired: true,
                            onSelect: (val) async {
                              setState(() {
                                selectedUnion = val;
                                unionCon.text = val;
                              });
                            },
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: GlobalTextFormField(
                            controller: fishNameCon,
                            titleText: "Fish Name",
                            hintText: "Enter fish name",
                            decoration: borderDecoration,
                            isDense: true,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),

                    sizedBoxH(10),
                    GestureDetector(
                      onTap: () {
                        showCustomSnackBar("Map integration coming soon!");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorRes.grey, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: GlobalText(
                                  str: "Map integration",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            sizedBoxW(10),
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),

                    sizedBoxH(20),
                    GlobalButtonWidget(
                      str: 'Submit',
                      height: 45,
                      onTap: () async {
                        if (pondNameCon.text.isEmpty) {
                          showCustomSnackBar("Pond Name is required");
                        } else if (pondLocCon.text.isEmpty) {
                          showCustomSnackBar("Pond Location is required");
                        } else if (sizeCon.text.isEmpty) {
                          showCustomSnackBar("Size is required");
                        } else if (depthCon.text.isEmpty) {
                          showCustomSnackBar("Depth is required");
                        } else if (selectedUpazila == null) {
                          showCustomSnackBar("Upazila is required");
                        } else if (selectedDistrict == null) {
                          showCustomSnackBar("District is required");
                        } else if (selectedUnion == null) {
                          showCustomSnackBar("Union is required");
                        } else if (fishNameCon.text.isEmpty) {
                          showCustomSnackBar("Fish Name is required");
                        } else {
                          // All validation passed
                          showCustomSnackBar("Pond added successfully!");
                          Get.back();
                        }
                      },
                    ),
                    sizedBoxH(20),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}