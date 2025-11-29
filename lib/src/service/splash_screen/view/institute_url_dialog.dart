import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_textform_field.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/input_decoration.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';

class InstituteUrlDialog extends StatefulWidget {
  final Function(String url) onUrlSubmitted;

  const InstituteUrlDialog({
    super.key,
    required this.onUrlSubmitted,
  });

  @override
  State<InstituteUrlDialog> createState() => _InstituteUrlDialogState();
}

class _InstituteUrlDialogState extends State<InstituteUrlDialog> {
  final TextEditingController _urlController = TextEditingController(text: "https://ems.stitbd.net");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _submitUrl() {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text.trim();
      widget.onUrlSubmitted(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AlertDialog(
          backgroundColor: ColorRes.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          content: SizedBox(
            width: Get.width,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    sizedBoxH(20),
                    GlobalText(
                      str: "Institute URL",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: ColorRes.black,
                    ),

                    GlobalText(
                      str: "Please enter your institute's URL to continue",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.grey,
                      textAlign: TextAlign.center,
                    ),
                    sizedBoxH(20),

                    // URL Input Field
                    GlobalTextFormField(
                      controller: _urlController,
                      hintText: "Enter institute URL",
                      isDense: true,
                      decoration: borderDecoration,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a URL';
                        }
                        // Basic URL validation
                        if (!value.contains('.')) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                    ),

                    sizedBoxH(20),
                    SizedBox(
                      width: double.infinity,
                      child: GlobalButtonWidget(
                        str: "Submit",
                        height: 35,
                        radius: 8,
                        textSize: 14,
                        onTap: _submitUrl,
                      ),
                    ),
                    sizedBoxH(12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}