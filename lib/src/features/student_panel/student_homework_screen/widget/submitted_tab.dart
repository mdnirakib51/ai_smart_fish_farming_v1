import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'student_homework_widget.dart';

class StudentSubmittedTab extends StatefulWidget {
  const StudentSubmittedTab({
    super.key,
  });

  @override
  State<StudentSubmittedTab> createState() => _StudentSubmittedTabState();
}

class _StudentSubmittedTabState extends State<StudentSubmittedTab> {

  final List<PlatformFile?> uploadedFiles = List.filled(7, null);
  final List<bool> submissionStatus = List.filled(7, false);

  void handleFileSelection(int index, PlatformFile? file) {
    setState(() {
      uploadedFiles[index] = file;
    });

    if (file != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File "${file.name}" selected for homework ${index + 1}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> selectFile(int index) async {
    // This method is kept for compatibility but actual file selection
    // is now handled in the widget itself
    print('File selection handled by StudentHomeworkWidget');
  }

  Future<void> submitHomework(int index) async {
    if (uploadedFiles[index] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a document before submitting!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulate submission process
    setState(() {
      submissionStatus[index] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Homework ${index + 1} submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 550,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return StudentHomeworkWidget(
            subject: 'English',
            code: '101',
            status: submissionStatus[index] ? 'Submitted' : 'Pending',
            homeworkDate: '07/26/2025',
            submissionDate: '08/29/2025',
            createdBy: 'Rafi Ahmed',
            marks: '35.00',
            topic: "The Role of Newton's Laws in Everyday Life",
            description: "Explore and explain how Newton's three laws of motion apply to real-life scenarios. Include examples like driving a car, riding a bicycle, walking, or sports activities.",
            note: 'Please submit your Homework before the deadline. Otherwise, 50% of the marks will be deducted.',
            itemCount: index + 1,
            uploadedFileName: uploadedFiles[index]?.name,
            isSubmitted: submissionStatus[index],
            onUploadDocument: () => selectFile(index),
            onSubmit: () => submitHomework(index),
            onFileSelected: (file) => handleFileSelection(index, file),
          );
        },
      ),
    );
  }
}