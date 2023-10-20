// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/complaints_service.dart';
import 'package:fyp_mobile/themes/colors.dart';

class CreateComplaintPopup extends StatefulWidget {
  const CreateComplaintPopup({Key? key}) : super(key: key);

  @override
  State<CreateComplaintPopup> createState() => _CreateComplaintPopupState();
}

class _CreateComplaintPopupState extends State<CreateComplaintPopup> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _complaintsService = ComplaintsService();
  final _authService = AuthService();

  Future<void> _handleCreateComplaint() async {
    final email = await _authService.getUserEmail();

    final title = titleController.text;
    final desc = descriptionController.text;

    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required!"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        await _complaintsService.createComplaint(
          title,
          desc,
          email,
        );

        // Handle successful leave creation here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Complaint created successfully!"),
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
            content: Text("Failed to create complaint"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make Complaint',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
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
            _handleCreateComplaint();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
