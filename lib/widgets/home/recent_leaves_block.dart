import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/themes/spacing.dart';
import 'package:fyp_mobile/widgets/home/recent_leaves_card.dart';

class RecentLeavesBlock extends StatefulWidget {
  const RecentLeavesBlock({super.key});

  @override
  State<RecentLeavesBlock> createState() => _RecentLeavesBlockState();
}

class _RecentLeavesBlockState extends State<RecentLeavesBlock> {
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
                      color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecentLeavesCard(
                  title: '23/10/16 to 23/10/18',
                  status: "Approved",
                  icon: Icons.done,
                ),
                SizedBox(
                  height: defaultTextFieldHeightSpacing,
                ),
                RecentLeavesCard(
                  title: '23/10/16 to 23/10/18',
                  status: "Rejected",
                  icon: Icons.more_horiz_rounded,
                ),
                SizedBox(
                  height: defaultTextFieldHeightSpacing,
                ),
                RecentLeavesCard(
                  title: '23/10/16 to 23/10/18',
                  status: "Pending",
                  icon: Icons.close,
                ),
                SizedBox(
                  height: defaultTextFieldHeightSpacing,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
