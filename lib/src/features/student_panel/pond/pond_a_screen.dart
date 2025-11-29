
import 'package:ai_smart_fish_farming/src/global/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/utils/show_toast.dart';
import '../../../global/widget/global_text.dart';
import '../home_screen/view/widget/temperaturn_graph_painter.dart';
import 'pond_a_details_screen.dart';

class PondAScreen extends StatefulWidget {
  const PondAScreen({super.key});

  @override
  State<PondAScreen> createState() => _PondAScreenState();
}

class _PondAScreenState extends State<PondAScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.appBackColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: GlobalAppBar(
          title: GlobalText(
            str: "Pond A",
            color: ColorRes.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          isBackIc: true,
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showCustomSnackBar("ChatBot feature coming soon!");
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorRes.appColor,
                ColorRes.appColor.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: ColorRes.appColor.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: Offset(0, 8),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              GlobalText(
                str: "ChatBot",
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather API Data Header Card
            buildWeatherWidget(),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         Color(0xFF0096C7).withValues(alpha: 0.15),
            //         Color(0xFF0096C7).withValues(alpha: 0.08),
            //       ],
            //     ),
            //     borderRadius: BorderRadius.circular(20),
            //     border: Border.all(
            //       color: Color(0xFF0096C7).withValues(alpha: 0.3),
            //       width: 1.5,
            //     ),
            //   ),
            //   child: Center(
            //     child: GlobalText(
            //       str: "Weather API DATA",
            //       color: Color(0xFF0096C7),
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            SizedBox(height: 20),

            // First Row - PH Level & TDS
            Row(
              children: [
                Expanded(
                  child: _buildDataCard(
                    title: "PH Level",
                    value: "7.2",
                    status: "Optimal",
                    color: Color(0xFF0096C7).withValues(alpha: 0.12),
                    borderColor: Color(0xFF0096C7).withValues(alpha: 0.3),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDataCard(
                    title: "TDS",
                    value: "4.3",
                    status: "optimal",
                    color: Color(0xFF0096C7).withValues(alpha: 0.12),
                    borderColor: Color(0xFF0096C7).withValues(alpha: 0.3),
                    onTap: (){
                      Get.to(()=> PondADetailsScreen());
                    }
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Second Row - DO Level & Temp
            Row(
              children: [
                Expanded(
                  child: _buildDataCard(
                    title: "DO Level",
                    value: "7.2",
                    status: "Optimal",
                    color: Color(0xFF0096C7).withValues(alpha: 0.12),
                    borderColor: Color(0xFF0096C7).withValues(alpha: 0.3),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDataCard(
                    title: "Temp",
                    value: "4.3",
                    status: "optimal",
                    color: Color(0xFF0096C7).withValues(alpha: 0.12),
                    borderColor: Color(0xFF0096C7).withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Third Row - Turbidity Level & Ammonia
            Row(
              children: [
                Expanded(
                  child: _buildDataCard(
                    title: "TurbidityLevel",
                    value: "7.2",
                    status: "Optimal",
                    color: Color(0xFF0096C7).withValues(alpha: 0.12),
                    borderColor: Color(0xFF0096C7).withValues(alpha: 0.3),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDataCard(
                    title: "Ammonia",
                    value: "7.2",
                    status: "Optimal",
                    color: Color(0xFF0096C7).withValues(alpha: 0.12),
                    borderColor: Color(0xFF0096C7).withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),

            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard({
    required String title,
    required String value,
    required String status,
    required Color color,
    required Color borderColor,
    void Function()? onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalText(
              str: title,
              color: Color(0xFF0096C7),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8),
            GlobalText(
              str: value,
              color: Color(0xFF006D8F),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 4),
            GlobalText(
              str: status,
              color: Color(0xFF0096C7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}