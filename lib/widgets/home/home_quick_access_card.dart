import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';

class HomeQuickAccessCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const HomeQuickAccessCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<HomeQuickAccessCard> createState() => _HomeQuickAccessCardState();
}

class _HomeQuickAccessCardState extends State<HomeQuickAccessCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 170,
        width: 125,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(200),
              ),
              child: Icon(
                widget.icon,
                color: AppColors.textColorDark,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
                child: Text(
              widget.title,
              style: const TextStyle(
                  color: AppColors.textColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }
}
