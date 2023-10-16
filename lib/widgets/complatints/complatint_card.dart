import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';

class ComplaintCard extends StatelessWidget {
  final String title1;
  final String title2;
  final IconData icon;
  final String iconText;
  final VoidCallback onPressed;

  const ComplaintCard({
    Key? key,
    required this.title1,
    required this.title2,
    required this.icon,
    required this.iconText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10.0),
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
          padding:
              const EdgeInsets.all(16.0), // Apply padding to the card's contents
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColorLight,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                title2,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textColorLight,
                ),
              ),
              const SizedBox(height: 12.0),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 276) {
                    return Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.vertical,
                      spacing: 8.0,
                      children: _buildChildren(context),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildChildren(context),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(context) {
    return [
      Row(
        children: [
          Icon(icon, color: AppColors.textColorLight),
          const SizedBox(width: 8.0),
          Text(
            iconText,
            style: const TextStyle(color: AppColors.textColorLight),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    ];
  }
}
