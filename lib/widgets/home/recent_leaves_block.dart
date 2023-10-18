import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/leaves_service.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/widgets/home/recent_leaves_card.dart';

class RecentLeavesBlock extends StatefulWidget {
  const RecentLeavesBlock({super.key});

  @override
  State<RecentLeavesBlock> createState() => _RecentLeavesBlockState();
}

class _RecentLeavesBlockState extends State<RecentLeavesBlock> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              child: Text(
                'Recent Leaves',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/leaves');
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var leave in leavesList.take(3))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RecentLeavesCard(
                      title:
                          "${leave.startDate.year.toString()}/${leave.startDate.month.toString()}/${leave.startDate.day.toString()} to ${leave.endDate.year.toString()}/${leave.endDate.month.toString()}/${leave.endDate.day.toString()}",
                      status: leave.status,
                      icon: Icons.done,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
