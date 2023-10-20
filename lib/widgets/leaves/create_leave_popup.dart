import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/leaves_service.dart';
import 'package:fyp_mobile/themes/colors.dart';

class CreateLeavePopup extends StatefulWidget {
  const CreateLeavePopup({super.key});

  @override
  State<CreateLeavePopup> createState() => _CreateLeavePopupState();
}

class _CreateLeavePopupState extends State<CreateLeavePopup> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  final TextEditingController requestedUserReasonController =
      TextEditingController();

  final _authService = AuthService();
  final _leavesService = LeavesService();

  Future<void> _handleCreateLeave() async {
    final email = await _authService.getUserEmail();
    final startDate = selectedStartDate.toString();
    final endDate = selectedEndDate.toString();
    final requestedDate = DateTime.now().toString();
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
        await _leavesService.createLeave(
          startDate,
          endDate,
          requestedDate,
          email,
          reason,
        );

        // Handle successful leave creation here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Leave created successfully!"),
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
            content: Text("Failed to create leave"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request Leave', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
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
              decoration:
                  const InputDecoration(labelText: 'Reason for Request'),
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
            _handleCreateLeave();
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
