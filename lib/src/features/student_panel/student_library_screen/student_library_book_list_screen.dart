import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../student_home_screen/model/student_library_model.dart';
import 'widget/student_library_widget.dart';

class StudentLibraryBookListScreen extends StatefulWidget {
  const StudentLibraryBookListScreen({super.key});

  @override
  State<StudentLibraryBookListScreen> createState() => _StudentLibraryBookListScreenState();
}

class _StudentLibraryBookListScreenState extends State<StudentLibraryBookListScreen> {

  @override
  void initState() {
    super.initState();
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentLibraryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Library Books",
          expandedHeight: 60,
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Stats header
          SliverToBoxAdapter(
            child: _buildStatsHeader(homePageController),
          ),

          sliverSizedBoxH(16),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: _buildBookList(homePageController),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }

  Widget _buildStatsHeader(StudentHomePageController controller) {
    if (controller.studentLibraryModel == null) return const SizedBox.shrink();

    final totalBooks = controller.studentLibraryModel!.length;
    final issuedBooks = controller.studentLibraryModel!
        .where((book) => book.status?.toLowerCase() == 'issued' || book.status?.toLowerCase() == 'active')
        .length;
    final returnedBooks = controller.studentLibraryModel!
        .where((book) => book.status?.toLowerCase() == 'returned')
        .length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          _buildStatItem(
            icon: Icons.library_books,
            title: "Total",
            value: totalBooks.toString(),
            color: Colors.blue,
          ),
          _buildStatItem(
            icon: Icons.bookmark,
            title: "Issued",
            value: issuedBooks.toString(),
            color: Colors.green,
          ),
          _buildStatItem(
            icon: Icons.check_circle,
            title: "Returned",
            value: returnedBooks.toString(),
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(StudentHomePageController controller) {
    // Show error state
    if (controller.hasError) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load books',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please check your connection and try again',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => controller.getStudentLibraryList(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show empty state
    if (controller.studentLibraryModel == null || controller.studentLibraryModel!.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_books_outlined,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No books found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You haven\'t issued any books yet',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show books list
    return SliverList.builder(
      itemCount: controller.studentLibraryModel!.length,
      itemBuilder: (context, index) {
        final book = controller.studentLibraryModel![index];

        return StudentLibraryWidget(
          bookName: book.bookName ?? "Unknown Book",
          invoice: book.invoice?.toString() ?? "N/A",
          issueDate: book.issuedDate ?? "N/A",
          returnDate: book.returnDate ?? "N/A",
          status: book.status ?? "Unknown",
          quantity: "1", // You can modify this based on your data
          onTap: (){},
          // onTap: () => _showBookDetails(book),
        );
      },
    );
  }

  void _showBookDetails(StudentLibraryModel book) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Book title
            Text(
              book.bookName ?? "Book Details",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Details
            _buildDetailRow("Invoice Number", "#${book.invoice}"),
            _buildDetailRow("Status", book.status ?? "Unknown"),
            _buildDetailRow("Issue Date", book.issuedDate ?? "N/A"),
            _buildDetailRow("Return Date", book.returnDate ?? "N/A"),

            const SizedBox(height: 20),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Close"),
              ),
            ),

            // Safe area padding
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(": "),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}