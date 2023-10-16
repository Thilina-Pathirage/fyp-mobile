import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/widgets/common/common_small_button.dart';

class RecentLeavesCard extends StatefulWidget {
  final String title;
  final String status;
  final IconData icon;
  const RecentLeavesCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.status});

  @override
  State<RecentLeavesCard> createState() => RecentLeavesCardState();
}

class RecentLeavesCardState extends State<RecentLeavesCard> {
  Color setIconBgColor(status) {
    if (status == "Approved") {
      return Colors.green.withOpacity(0.2);
    } else if (status == "Rejected") {
      return Colors.red.withOpacity(0.2);
    } else {
      return Colors.amber.withOpacity(0.2);
    }
  }

  Color setIconColor(status) {
    if (status == "Approved") {
      return Colors.green;
    } else if (status == "Rejected") {
      return Colors.red;
    } else {
      return Colors.amber;
    }
  }

  IconData setIcon(status) {
    if (status == "Approved") {
      return Icons.done;
    } else if (status == "Rejected") {
      return Icons.close;
    } else {
      return Icons.more_horiz_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 250) {
                  // Change the value 600 as per your need
                  return buildRowLayout(
                      widget.title,
                      setIcon(widget.status),
                      setIconColor(widget.status),
                      setIconBgColor(widget.status), widget.status);
                } else {
                  return buildColumnLayout(
                      widget.title,
                      setIcon(widget.status),
                      setIconColor(widget.status),
                      setIconBgColor(widget.status), widget.status);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRowLayout(title, icon, iconColor, iconBg, status) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(200),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 40,
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.textColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            status,
            style: const TextStyle(color: AppColors.greyColor, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ],
  );
}

Widget buildColumnLayout(title, icon, iconColor, iconBg, status) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(200),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 40,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.textColorLight,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            status,
            style: const TextStyle(color: AppColors.greyColor, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      const SizedBox(
        height: 16,
      )
    ],
  );
}
