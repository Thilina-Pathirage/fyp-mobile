import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';

class CreateComplaintPopup extends StatefulWidget {
  const CreateComplaintPopup({Key? key}) : super(key: key);

  @override
  State<CreateComplaintPopup> createState() => _CreateComplaintPopupState();
}

class _CreateComplaintPopupState extends State<CreateComplaintPopup> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Make Complaint'),
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
           
            // Close the dialog
            Navigator.of(context).pop();
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
