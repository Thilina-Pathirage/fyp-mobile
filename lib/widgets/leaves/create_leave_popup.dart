import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/themes/colors.dart';

class CreateLeavePopup extends StatefulWidget {
  const CreateLeavePopup({super.key});

  @override
  State<CreateLeavePopup> createState() => _CreateLeavePopupState();
}

class _CreateLeavePopupState extends State<CreateLeavePopup> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController requestedUserReasonController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request Leave'),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
            ),
            TextFormField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
            ),
            TextFormField(
              controller: requestedUserReasonController,
              decoration: const InputDecoration(labelText: 'Reason for Requst'),
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
          onPressed: () {
            // Add the new leave to the list and close the dialog

            Navigator.of(context).pop(); // Close the dialog
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
