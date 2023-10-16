import 'package:flutter/material.dart';
import 'package:fyp_mobile/models/cmplaint.dart';
import 'package:fyp_mobile/widgets/common/custom_appbar.dart';
import 'package:fyp_mobile/widgets/common/floating_action_button.dart';
import 'package:fyp_mobile/widgets/complatints/complatint_card.dart';
import 'package:fyp_mobile/widgets/complatints/create_complaint_popup.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsScreen> createState() => ComplaintsScreenState();
}

class ComplaintsScreenState extends State<ComplaintsScreen> {
  String selectedFilter = "All"; // Default filter is "All"

  List<Complaint> dummyComplaints = [
    Complaint(
      id: "6525738745f8caa2e567b2db",
      title: "Too much workload",
      description: "Too much workload on my head, I'm very stressed!",
      createdUserEmail: "abc@gmail.com",
    ),
  ];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            children: [
              for (var c in dummyComplaints)
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
