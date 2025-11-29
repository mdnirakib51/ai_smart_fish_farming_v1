
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class EventDetailDialog extends StatelessWidget {
  const EventDetailDialog({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.category,
    required this.registeredStudents,
    required this.description,
  });
  final String title;
  final String date;
  final String location;
  final String category;
  final String registeredStudents;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorRes.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ColorRes.appColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: GlobalText(
                            str: category,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: GlobalText(
                            str: '$registeredStudents Students',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(5),
                    GlobalText(
                      str: title,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.event,
                            color: ColorRes.white,
                            size: 20,
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: "Date & Time",
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: ColorRes.grey,
                              ),
                              GlobalText(
                                str: date,
                                color: ColorRes.deep400,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.place_outlined,
                            color: ColorRes.white,
                            size: 20,
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: "Location",
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: ColorRes.grey,
                              ),
                              GlobalText(
                                str: location,
                                color: ColorRes.deep400,
                                fontWeight: FontWeight.w600,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(15),
                    GlobalText(
                      str: 'Description',
                      fontSize: 12,
                      color: ColorRes.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    sizedBoxH(3),
                    GlobalText(
                      str: description,
                      fontSize: 14,
                      color: ColorRes.deep400,
                    ),
                    sizedBoxH(15),
                    GlobalButtonWidget(
                      str: 'Close',
                      textColor: ColorRes.white,
                      borderColor: ColorRes.appColor,
                      buttomColor: ColorRes.appColor,
                      height: 45,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}