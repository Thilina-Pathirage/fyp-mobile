import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/leaves_service.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/themes/spacing.dart';
import 'package:fyp_mobile/widgets/common/custom_appbar.dart';
import 'package:fyp_mobile/widgets/common/floating_action_button.dart';
import 'package:fyp_mobile/widgets/home/recent_leaves_card.dart';
import 'package:fyp_mobile/widgets/leaves/create_leave_popup.dart';
import 'package:fyp_mobile/widgets/leaves/update_leave_popup.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({Key? key}) : super(key: key);

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  String selectedFilter = "All"; // Default filter is "All"
  String _name = "";
  String _email = "";

  bool _isLoading = true;

  List<Leave> leavesList = [];

  final _leavesService = LeavesService();
  final _authService = AuthService();

  Future<void> _getName() async {
    try {
      final name = await _authService.getUserName();
      if (mounted) {
        setState(() {
          _name = name;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _handleLeaves() async {
    try {
      final email = await _authService.getUserEmail();

      var leaves = await _leavesService.getLeavesByUser(email);

      leaves = leaves.reversed.toList();

      if (mounted) {
        setState(() {
          leavesList = leaves;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Request failed!"),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getName();
    // _getEmail();
    _handleLeaves();
  }

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
              for (var leave in leavesList)
                if (selectedFilter == "All" || leave.status == selectedFilter)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: InkWell(
                      onLongPress: () {
                        _showUpdateLeaveDialog(context, leave);
                      },
                      child: RecentLeavesCard(
                        title:
                            "${leave.startDate.year.toString()}/${leave.startDate.month.toString()}/${leave.startDate.day.toString()} to ${leave.endDate.year.toString()}/${leave.endDate.month.toString()}/${leave.endDate.day.toString()}",
                        status: leave.status,
                        icon: Icons.done,
                      ),
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

    Future<void> _showUpdateLeaveDialog(BuildContext context, leave) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateLeavePopup(leave: leave);
      },
    );
  }
}
