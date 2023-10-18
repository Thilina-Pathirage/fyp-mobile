import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/leaves_service.dart';
import 'package:fyp_mobile/themes/colors.dart';

class UpdateLeavePopup extends StatefulWidget {
  final Leave leave;
  const UpdateLeavePopup({super.key, required this.leave});

  @override
  State<UpdateLeavePopup> createState() => _UpdateLeavePopupState();
}

class _UpdateLeavePopupState extends State<UpdateLeavePopup> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final TextEditingController requestedUserReasonController =
      TextEditingController();

  final _authService = AuthService();
  final _leavesService = LeavesService();

  Future<void> _handleUpdateLeave() async {
    final leavID = widget.leave.id;
    final startDate = selectedStartDate.toString();
    final endDate = selectedEndDate.toString();
    final reason = requestedUserReasonController.text;

    if (selectedStartDate == null ||
        selectedEndDate == null ||
        requestedUserReasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required!"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        await _leavesService.updateLeave(leavID, startDate, endDate, reason);

        // Handle successful leave creation here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Leave updated successfully!"),
            backgroundColor: AppColors.primaryColor,
          ),
        );
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, '/home');

        // You can use `createdLeave` if you want to access the created leave details
      } catch (e) {
        // Handle any exceptions that occur during leave creation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update leave"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Leave'),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Start Date Picker
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Start Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: widget.leave.startDate,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2101),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        setState(() {
                          selectedStartDate = pickedDate;
                        });
                      }
                    });
                  },
                  child: Text(
                    selectedStartDate != null
                        ? "${selectedStartDate!.year}-${selectedStartDate!.month}-${selectedStartDate!.day}"
                        : 'Select Date',
                    style: TextStyle(
                      color: selectedStartDate != null
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            // End Date Picker
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'End Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: widget.leave.endDate,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2101),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        setState(() {
                          selectedEndDate = pickedDate;
                        });
                      }
                    });
                  },
                  child: Text(
                    selectedEndDate != null
                        ? "${selectedEndDate!.year}-${selectedEndDate!.month}-${selectedEndDate!.day}"
                        : 'Select Date',
                    style: TextStyle(
                      color:
                          selectedEndDate != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            TextFormField(
              controller: requestedUserReasonController,
              // initialValue: widget.leave.reason ?? "",
              decoration: const InputDecoration(labelText: 'Reason for Leave'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Add the new leave to the list and close the dialog
            _handleUpdateLeave();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor:
                  AppColors.primaryColor // Highlight the selected filter
              ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
