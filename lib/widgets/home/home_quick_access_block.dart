import 'package:flutter/material.dart';
import 'package:fyp_mobile/widgets/home/home_quick_access_card.dart';

class HomeQuickAccessBlock extends StatefulWidget {
  const HomeQuickAccessBlock({super.key});

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
            padding: const EdgeInsets.only(bottom: 16.0, left: 5, right: 8.0),
            child: Row(
              children: [
                HomeQuickAccessCard(
                  title: 'Take Survy',
                  icon: Icons.document_scanner_outlined,
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
}