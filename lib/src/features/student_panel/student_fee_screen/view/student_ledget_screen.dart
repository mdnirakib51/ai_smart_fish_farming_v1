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

class StudentLedgerScreen extends StatefulWidget {
  final bool? isBackIc;
  const StudentLedgerScreen({
    super.key,
    this.isBackIc = true,
  });

  @override
  State<StudentLedgerScreen> createState() => _StudentLedgerScreenState();
}

class _StudentLedgerScreenState extends State<StudentLedgerScreen> {

  int selectedTab = 0;
  final tabDataList = ["Initial Fees", "Paid Fees", "Unpaid Fees", "Discounts"];

  @override
  void initState() {
    super.initState();
    final studentHomeController = StudentFeeController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsLedgerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentFeeController>(builder: (studentFeeController) {
      final ledgerData = studentFeeController.studentLedgerModel;

      return CustomScrollViewWidget(
        inAsyncCall: studentFeeController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Payment Ledger",
          centerTitle: widget.isBackIc == false ? true : false,
          isBackIc: widget.isBackIc,
          expandedHeight: 300,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: Column(
                children: [
                  StudentMenuBackgroundContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Student Information
                        if (ledgerData?.student != null) ...[
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorRes.appColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: ColorRes.appColor,
                                  size: 20,
                                ),
                              ),
                              sizedBoxW(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlobalText(
                                      str: ledgerData!.student!.name ?? 'Student',
                                      color: ColorRes.appColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    GlobalText(
                                      str: 'ID: ${ledgerData.student!.uniqueId ?? 'N/A'}',
                                      color: ColorRes.deep400,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
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
                                  str: ledgerData.session ?? DateTime.now().year.toString(),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          sizedBoxH(15),
                        ],

                        // Fee Summary
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
                                studentFeeController.formatAmount(ledgerData?.totals?.totalInitial ?? 0),
                                Icons.account_balance_wallet,
                              ),
                            ),
                            Expanded(
                              child: _buildSummaryItem(
                                'Total Paid',
                                studentFeeController.formatAmount(ledgerData?.totals?.totalPaid ?? 0),
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
                                'Total Due',
                                studentFeeController.formatAmount(ledgerData?.totals?.totalDue ?? 0),
                                Icons.pending,
                              ),
                            ),
                            Expanded(
                              child: _buildSummaryItem(
                                'Discount',
                                studentFeeController.formatAmount(ledgerData?.totals?.totalDiscount ?? 0),
                                Icons.local_offer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                      str: 'Failed to load ledger data',
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

          // Ledger Data
          else if (ledgerData != null) ...[
              // Tab Selector
              SliverToBoxAdapter(
                child: Container(
                  width: size(context).width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(4),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tabDataList.asMap().entries.map((item) {
                        bool isSelected = selectedTab == item.key;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = item.key;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isSelected
                                  ? ColorRes.appColor
                                  : Colors.transparent,
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: ColorRes.appColor.withValues(alpha:0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                                  : null,
                            ),
                            child: Center(
                              child: AnimatedScale(
                                scale: isSelected ? 1.05 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: GlobalText(
                                  str: item.value,
                                  color: isSelected
                                      ? Colors.white
                                      : ColorRes.black.withValues(alpha:0.7),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  fontSize: isSelected ? 13 : 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              sliverSizedBoxH(15),
              if (selectedTab == 0)
                ..._buildInitialFeesList(studentFeeController, ledgerData)
              else if (selectedTab == 1)
                ..._buildPaidFeesList(studentFeeController, ledgerData)
              else if (selectedTab == 2)
                ..._buildUnpaidFeesList(studentFeeController, ledgerData)
              else
                ..._buildDiscountsList(studentFeeController, ledgerData),
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
                        str: 'No ledger data available',
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

  List<Widget> _buildInitialFeesList(StudentFeeController controller, dynamic ledgerData) {
    final initialFees = ledgerData.initialFees ?? [];

    if (initialFees.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: _buildEmptyState('No initial fees found', Icons.account_balance_wallet),
        )
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final fee = initialFees[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorRes.appColor.withValues(alpha: 0.2),
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
                        color: ColorRes.appColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: ColorRes.appColor,
                        size: 20,
                      ),
                    ),
                    sizedBoxW(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: fee.accountHead ?? 'Fee',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorRes.black,
                          ),
                          sizedBoxH(2),
                          GlobalText(
                            str: fee.feeMonth ?? '',
                            fontSize: 12,
                            color: ColorRes.deep400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlobalText(
                          str: controller.formatAmount(fee.amount ?? 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorRes.appColor,
                        ),
                        GlobalText(
                          str: fee.date ?? '',
                          fontSize: 10,
                          color: ColorRes.deep400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
          childCount: initialFees.length,
        ),
      ),
    ];
  }

  List<Widget> _buildPaidFeesList(StudentFeeController controller, dynamic ledgerData) {
    final paidFees = ledgerData.paidFees ?? [];

    if (paidFees.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: _buildEmptyState('No paid fees found', Icons.check_circle),
        )
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final fee = paidFees[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green.withValues(alpha: 0.2),
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
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    sizedBoxW(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: fee.accountHead ?? 'Fee Payment',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorRes.black,
                          ),
                          sizedBoxH(2),
                          GlobalText(
                            str: fee.feeMonth ?? '',
                            fontSize: 12,
                            color: ColorRes.deep400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlobalText(
                          str: controller.formatAmount(fee.amount ?? 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        GlobalText(
                          str: 'Paid: ${fee.paidDate ?? ''}',
                          fontSize: 10,
                          color: ColorRes.deep400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
          childCount: paidFees.length,
        ),
      ),
    ];
  }

  List<Widget> _buildUnpaidFeesList(StudentFeeController controller, dynamic ledgerData) {
    final unpaidFees = ledgerData.unpaidFees ?? [];

    if (unpaidFees.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: _buildEmptyState('No unpaid fees found', Icons.pending),
        )
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final fee = unpaidFees[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.red.withValues(alpha: 0.2),
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
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.pending,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    sizedBoxW(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: fee.accountHead ?? 'Unpaid Fee',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorRes.black,
                          ),
                          sizedBoxH(2),
                          GlobalText(
                            str: fee.feeMonth ?? '',
                            fontSize: 12,
                            color: ColorRes.deep400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlobalText(
                          str: controller.formatAmount(fee.amount ?? 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        GlobalText(
                          str: 'Due: ${fee.date ?? ''}',
                          fontSize: 10,
                          color: ColorRes.deep400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
          childCount: unpaidFees.length,
        ),
      ),
    ];
  }

  List<Widget> _buildDiscountsList(StudentFeeController controller, dynamic ledgerData) {
    final discounts = ledgerData.discounts ?? [];

    if (discounts.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: _buildEmptyState('No discounts found', Icons.local_offer),
        )
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final discount = discounts[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue.withValues(alpha: 0.2),
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
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.local_offer,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    sizedBoxW(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: discount.accountHead ?? 'Discount',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorRes.black,
                          ),
                          sizedBoxH(2),
                          if (discount.note != null && discount.note!.isNotEmpty)
                            GlobalText(
                              str: discount.note!,
                              fontSize: 12,
                              color: ColorRes.deep400,
                            ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlobalText(
                          str: controller.formatAmount(discount.amount ?? 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        GlobalText(
                          str: discount.discountDate ?? '',
                          fontSize: 10,
                          color: ColorRes.deep400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
          childCount: discounts.length,
        ),
      ),
    ];
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey, size: 40),
          sizedBoxH(10),
          GlobalText(
            str: message,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ],
      ),
    );
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