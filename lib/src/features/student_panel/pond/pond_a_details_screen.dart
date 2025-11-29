import 'package:ai_smart_fish_farming/src/global/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/utils/show_toast.dart';
import '../../../global/widget/global_text.dart';

class PondADetailsScreen extends StatefulWidget {
  const PondADetailsScreen({super.key});

  @override
  State<PondADetailsScreen> createState() => _PondADetailsScreenState();
}

class _PondADetailsScreenState extends State<PondADetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.appBackColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: GlobalAppBar(
          title: GlobalText(
            str: "Pond A Details",
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
            // Forecasting Button
            _buildActionButton(
              "Forecasting\nButton",
              onTap: () {
                showCustomSnackBar("Forecasting feature coming soon!");
              },
            ),

            SizedBox(height: 16),

            // PH Plot Show basic Time Weekly
            _buildFeatureCard(
              "PH Plot Show basic\nTime Weekly",
              onTap: () {
                showCustomSnackBar("PH Plot feature coming soon!");
              },
            ),

            SizedBox(height: 16),

            // Morality Rate Monitoring Rate Plot Week
            _buildFeatureCard(
              "Morality Rate Monitoring\nRate Plot Week",
              onTap: () {
                showCustomSnackBar("Mortality Rate feature coming soon!");
              },
            ),

            SizedBox(height: 16),

            // Feed Effeciency Plot Week
            _buildFeatureCard(
              "Feed Effeciency Plot Week",
              onTap: () {
                showCustomSnackBar("Feed Efficiency feature coming soon!");
              },
            ),

            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8C4F5),
              Color(0xFFD8B4E8),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFD0A0E0).withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD8B4E8).withValues(alpha: 0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: GlobalText(
            str: text,
            color: Color(0xFF6B4C7A),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8C4F5).withValues(alpha: 0.8),
              Color(0xFFD8B4E8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFFD0A0E0).withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD8B4E8).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: GlobalText(
            str: text,
            color: Color(0xFF6B4C7A),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}