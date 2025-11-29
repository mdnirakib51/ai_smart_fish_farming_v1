import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/constants/input_decoration.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../global/widget/global_textform_field.dart';

class StudentDocumentsTab extends StatefulWidget {
  const StudentDocumentsTab({
    super.key,
  });

  @override
  State<StudentDocumentsTab> createState() => _StudentDocumentsTabState();
}

class _StudentDocumentsTabState extends State<StudentDocumentsTab> {
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController selectFileCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GlobalImageLoader(
            imagePath: Images.emptyIc,
            width: 120,
            height: 120,
            fit: BoxFit.fill,
          ),
          GlobalText(
            str: 'No Documents Yet',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
          GlobalText(
            str: 'Upload your first document to get started',
            fontSize: 13,
            color: Colors.grey[500],
          ),

          sizedBoxH(20),
          // Upload button at bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GlobalButtonWidget(
              img: Images.uploadIc,
              imgColor: ColorRes.white,
              str: 'Upload Document',
              height: 45,
              onTap: () {
                showModernUploadDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void showModernUploadDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        str: 'Upload Document',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      sizedBoxH(20),
                      GlobalTextFormField(
                        controller: titleCon,
                        hintText: 'Document Title',
                        decoration: borderDecoration,
                        isDense: true,
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      sizedBoxH(20),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: GlobalTextFormField(
                              controller: selectFileCon,
                              hintText: 'Select File',
                              decoration: borderDecoration,
                              isDense: true,
                              readOnly: true,
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                          sizedBoxW(12),
                          Expanded(
                            flex: 2,
                            child: GlobalButtonWidget(
                              str: 'Browse',
                              height: 45,
                              onTap: () {
                                _selectFile();
                              },
                            ),
                          ),
                        ],
                      ),
                      sizedBoxH(30),
                      Row(
                        children: [
                          Expanded(
                            child: GlobalButtonWidget(
                              str: 'Cancel',
                              textColor: ColorRes.appColor,
                              borderColor: ColorRes.appColor,
                              buttomColor: ColorRes.white,
                              height: 45,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          sizedBoxW(15),
                          Expanded(
                            child: GlobalButtonWidget(
                              str: 'Upload',
                              height: 45,
                              onTap: () {
                                _uploadDocument();
                              },
                            ),
                          ),
                        ],
                      ),
                      sizedBoxH(20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectFile() {
    // TODO: Implement file picker logic
    // Example: Use file_picker package
    // final result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   setState(() {
    //     selectFileCon.text = result.files.single.name;
    //   });
    // }

    // For now, just show a placeholder
    setState(() {
      selectFileCon.text = 'document.pdf';
    });
  }

  void _uploadDocument() {
    if (titleCon.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter document title')),
      );
      return;
    }

    if (selectFileCon.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a file')),
      );
      return;
    }

    // TODO: Implement upload logic
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Document uploaded successfully')),
    );
  }
}