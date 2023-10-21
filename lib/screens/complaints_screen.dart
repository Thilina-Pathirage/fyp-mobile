import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/cmplaint.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/complaints_service.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/widgets/common/custom_appbar.dart';
import 'package:fyp_mobile/widgets/common/floating_action_button.dart';
import 'package:fyp_mobile/widgets/complatints/complatint_card.dart';
import 'package:fyp_mobile/widgets/complatints/create_complaint_popup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsScreen> createState() => ComplaintsScreenState();
}

class ComplaintsScreenState extends State<ComplaintsScreen> {
  String selectedFilter = "All"; // Default filter is "All"

  List<Complaint> complaintsList = [];

  bool _isLoading = true;

  final _complaintsService = ComplaintsService();
  final _authService = AuthService();

  Future<void> _handleComplaints() async {
    try {
      final email = await _authService.getUserEmail();

      var complaints = await _complaintsService.getComplaintsByUser(email);

      complaints = complaints.reversed.toList();

      if (mounted) {
        setState(() {
          complaintsList = complaints;
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
    _handleComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Complaints'),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          _showCreateLeaveDialog(context);
        },
        heroTag: 'Make Complaints',
        icon: Icons.add,
        iconSize: 26,
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.fallingDot(
                  color: AppColors.primaryColor, size: 60))
          : complaintsList.isNotEmpty ? SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  _handleComplaints();
                },
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    children: [
                      for (var c in complaintsList)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ComplaintCard(
                                title1: c.title,
                                title2: c.description,
                                icon: Icons.person,
                                iconText: c.createdUserEmail,
                                onPressed: () {})),
                    ],
                  ),
                ),
              ),
            ) : const Center(
        child: SizedBox(
              child: Text('You can create complaints'),
            ),
      ),
    );
  }

  Future<void> _showCreateLeaveDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateComplaintPopup();
      },
    );
  }
}
