import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/themes/spacing.dart';
import 'package:fyp_mobile/widgets/common/custom_appbar.dart';
import 'package:fyp_mobile/widgets/common/floating_action_button.dart';
import 'package:fyp_mobile/widgets/home/recent_leaves_card.dart';
import 'package:fyp_mobile/widgets/leaves/create_leave_popup.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({Key? key}) : super(key: key);

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  String selectedFilter = "All"; // Default filter is "All"

  List<Leave> dummyLeaves = [
    Leave(
      id: "652bfc9b1014bcfdf7098c2a",
      startDate: DateTime.parse("2023-10-27"),
      endDate: DateTime.parse("2023-10-28"),
      requestedDate: DateTime.parse("2023-10-15"),
      requestedUserEmail: "ishan@gmail.com",
      status: "Pending",
    ),
    Leave(
      id: "652bfca11014bcfdf7098c2c",
      startDate: DateTime.parse("2023-10-27"),
      endDate: DateTime.parse("2023-10-28"),
      requestedDate: DateTime.parse("2023-10-15"),
      requestedUserEmail: "dinithi@gmail.com",
      status: "Approved",
    ),
    Leave(
      id: "652bfca71014bcfdf7098c2e",
      startDate: DateTime.parse("2023-10-27"),
      endDate: DateTime.parse("2023-10-28"),
      requestedDate: DateTime.parse("2023-10-15"),
      requestedUserEmail: "hancie@gmail.com",
      status: "Rejected",
    ),
    Leave(
      id: "652bfca71014bcfdf7098c2e",
      startDate: DateTime.parse("2023-10-27"),
      endDate: DateTime.parse("2023-10-28"),
      requestedDate: DateTime.parse("2023-10-15"),
      requestedUserEmail: "hancie@gmail.com",
      status: "Rejected",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'My Leaves'),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          _showCreateLeaveDialog(context);
        },
        heroTag: 'Create Leave',
        icon: Icons.add,
        iconSize: 26,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    filterButton("All"),
                    filterButton("Approved"),
                    filterButton("Rejected"),
                    filterButton("Pending"),
                  ],
                ),
              ),
              const SizedBox(height: defaultTextFieldHeightSpacing),
              // Display filtered RecentLeavesCard widgets based on the selected filter
              for (var leave in dummyLeaves)
                if (selectedFilter == "All" || leave.status == selectedFilter)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RecentLeavesCard(
                      title: leave.startDate.toString(),
                      status: leave.status,
                      icon: Icons.done,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterButton(String filter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedFilter = filter;
          });
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: selectedFilter == filter
              ? AppColors.primaryColor // Highlight the selected filter
              : AppColors.secondaryColor,
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: selectedFilter == filter
                ? AppColors.textColorDark // Highlight the selected filter
                : AppColors.textColorLight,
          ),
        ),
      ),
    );
  }

  Future<void> _showCreateLeaveDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateLeavePopup();
      },
    );
  }
}
