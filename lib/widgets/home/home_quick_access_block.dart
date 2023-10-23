import 'package:flutter/material.dart';
import 'package:fyp_mobile/widgets/home/home_quick_access_card.dart';
import 'package:fyp_mobile/widgets/home/tips_popup.dart';

class HomeQuickAccessBlock extends StatefulWidget {
  final List<dynamic>healthTips;
  const HomeQuickAccessBlock({super.key, required this.healthTips});

  @override
  State<HomeQuickAccessBlock> createState() => _HomeQuickAccessBlockState();
}

class _HomeQuickAccessBlockState extends State<HomeQuickAccessBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequent Menu',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0, left: 5, right: 8.0),
            child: Row(
              children: [
               widget.healthTips.isEmpty ? const SizedBox() : HomeQuickAccessCard(
                  title: 'Health Tips',
                  icon: Icons.model_training_rounded,
                  onPressed: () {
                    _showTipsDialog(context, widget.healthTips);
                  },
                ),
                 widget.healthTips.isEmpty ? const SizedBox() : const SizedBox(
                  width: 16,
                ),
                HomeQuickAccessCard(
                  title: 'Take Survey',
                  icon: Icons.insert_drive_file_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, '/survey');
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                HomeQuickAccessCard(
                  title: 'Time Off',
                  icon: Icons.exit_to_app_rounded,
                  onPressed: () {
                    Navigator.pushNamed(context, '/leaves');
                  },
                ),

                // ReminderCard(),
                const SizedBox(
                  width: 16,
                ),
                HomeQuickAccessCard(
                  title: 'Complaints',
                  icon: Icons.warning_amber_rounded,
                  onPressed: () {
                    Navigator.pushNamed(context, '/complaints');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showTipsDialog(BuildContext context, healthTips) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TipsPopup(healthTips: healthTips);
      },
    );
  }
}
