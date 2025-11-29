import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_flexible_space_back_widget.dart';
import '../../../widget/student_menu_background_container.dart';
import '../controller/student_fee_controller.dart';

class StudentFeeScreen extends StatefulWidget {
  const StudentFeeScreen({super.key});

  @override
  State<StudentFeeScreen> createState() => _StudentFeeScreenState();
}

class _StudentFeeScreenState extends State<StudentFeeScreen> {
  @override
  void initState() {
    super.initState();
    final studentHomeController = StudentFeeController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsFeeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentFeeController>(builder: (studentFeeController) {
      return CustomScrollViewWidget(
        inAsyncCall: studentFeeController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "School Fee",
          isBackIc: false,
          centerTitle: true,
          expandedHeight: 240,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: Column(
                children: [
                  StudentMenuBackgroundContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: 'Fee Summary',
                          color: ColorRes.appColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        sizedBoxH(10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSummaryItem(
                                'Total Assigned',
                                studentFeeController.formatAmount(studentFeeController.totalAssignedAmount),
                                Icons.account_balance_wallet,
                              ),
                            ),
                            Expanded(
                              child: _buildSummaryItem(
                                'Total Paid',
                                studentFeeController.formatAmount(studentFeeController.totalPaidAmount),
                                Icons.check_circle,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH(10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSummaryItem(
                                'Pending',
                                studentFeeController.formatAmount(studentFeeController.totalPendingAmount),
                                Icons.pending,
                              ),
                            ),
                            Expanded(
                              child: _buildSummaryItem(
                                'Due Items',
                                studentFeeController.unpaidFeeCount.toString(),
                                Icons.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   width: size(context).width,
                  //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: ColorRes.white.withValues(alpha: 0.2)
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 2),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             color: ColorRes.white
                  //         ),
                  //         child: Center(
                  //           child: Icon(
                  //             Icons.arrow_back_ios,
                  //             size: 14,
                  //             color: ColorRes.black,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Center(
                  //           child: GlobalText(
                  //               str: studentFeeController.currentSession,
                  //               color: ColorRes.white,
                  //               fontWeight: FontWeight.bold
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.only(right: 4, top: 5, bottom: 5, left: 6),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             color: ColorRes.white
                  //         ),
                  //         child: Center(
                  //           child: Icon(
                  //             Icons.arrow_forward_ios,
                  //             size: 14,
                  //             color: ColorRes.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              )
          ),
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Loading State
          if (studentFeeController.isLoading)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.appColor,
                  ),
                ),
              ),
            )

          // Error State
          else if (studentFeeController.hasError)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 40),
                    sizedBoxH(10),
                    GlobalText(
                      str: 'Failed to load fee data',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    sizedBoxH(5),
                    GlobalText(
                      str: 'Please try again later',
                      fontSize: 14,
                      color: Colors.red.withValues(alpha: 0.8),
                    ),
                  ],
                ),
              ),
            )

          // Fee Data
          else if (studentFeeController.studentFeeModel?.fees != null) ...[
              // Fee List Header
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorRes.appColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ColorRes.appColor.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorRes.appColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.calendar_month,
                          color: ColorRes.appColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: '${studentFeeController.currentSession} Fee Details',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorRes.black,
                            ),
                            const SizedBox(height: 2),
                            GlobalText(
                              str: 'Fee breakdown by category',
                              fontSize: 12,
                              color: ColorRes.deep400,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ColorRes.appColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GlobalText(
                          str: studentFeeController.currentSession,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Fee List
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final feeData = studentFeeController.studentFeeModel!.fees![index];
                  Color statusColor = _getStatusColor(feeData.status ?? '');
                  IconData statusIcon = _getStatusIcon(feeData.status ?? '');
                  bool isPaid = studentFeeController.isFeePaid(feeData);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                statusIcon,
                                color: statusColor,
                                size: 20,
                              ),
                            ),
                            sizedBoxW(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GlobalText(
                                    str: feeData.accountHead ?? 'Fee',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorRes.black,
                                  ),
                                  sizedBoxH(2),
                                  GlobalText(
                                    str: feeData.assignedMonth ?? '',
                                    fontSize: 12,
                                    color: ColorRes.deep400,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: statusColor, width: 1),
                              ),
                              child: GlobalText(
                                str: feeData.status ?? '',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),

                        sizedBoxH(12),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GlobalText(
                                    str: 'Assigned Fee:',
                                    fontSize: 13,
                                    color: ColorRes.deep400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  GlobalText(
                                    str: studentFeeController.formatAmount(feeData.amount ?? 0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorRes.black,
                                  ),
                                ],
                              ),

                              if ((feeData.paid ?? 0) > 0) ...[
                                sizedBoxH(6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GlobalText(
                                      str: 'Paid Amount:',
                                      fontSize: 13,
                                      color: ColorRes.deep400,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    GlobalText(
                                      str: studentFeeController.formatAmount(feeData.paid ?? 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],

                              if ((feeData.discount ?? 0) > 0) ...[
                                sizedBoxH(6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GlobalText(
                                      str: 'Discount:',
                                      fontSize: 13,
                                      color: ColorRes.deep400,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    GlobalText(
                                      str: studentFeeController.formatAmount(feeData.discount ?? 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ],

                              if (!isPaid) ...[
                                sizedBoxH(6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GlobalText(
                                      str: 'Due Amount:',
                                      fontSize: 13,
                                      color: ColorRes.deep400,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    GlobalText(
                                      str: studentFeeController.formatAmount(studentFeeController.getRemainingAmount(feeData)),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: ColorRes.red,
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        // if (!isPaid) ...[
                        //   sizedBoxH(12),
                        //   GlobalButtonWidget(
                        //     str: 'Pay Now',
                        //     height: 40,
                        //     radius: 8,
                        //     onTap: (){
                        //       Get.to(()=> StudentPaymentReviewScreen());
                        //     },
                        //   ),
                        // ],
                      ],
                    ),
                  );
                },
                  childCount: studentFeeController.studentFeeModel?.fees?.length ?? 0,
                ),
              ),
            ]

            // No Data State
            else
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.receipt_long, color: Colors.grey, size: 40),
                      sizedBoxH(10),
                      GlobalText(
                        str: 'No fee data available',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),

          sliverSizedBoxH(100),
        ],
      );
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Icons.check_circle;
      case 'unpaid':
        return Icons.pending;
      default:
        return Icons.info;
    }
  }

  Widget _buildSummaryItem(String title, String amount, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ColorRes.appColor.withValues(alpha: 0.8), size: 16),
        sizedBoxW(5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                str: title,
                color: Colors.black.withValues(alpha: 0.9),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              GlobalText(
                str: amount,
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}