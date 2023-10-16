import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';

class HomeStatCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final Color statBgColor;
  const HomeStatCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.statBgColor});

  @override
  State<HomeStatCard> createState() => _HomeStatCardState();
}

class _HomeStatCardState extends State<HomeStatCard> {
  @override
  Widget build(BuildContext context) {
    var width;

    width = MediaQuery.of(context).size.width;

    return Container(
      width: width / 4,
      height: width / 4,
      constraints: const BoxConstraints(minWidth: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: widget.statBgColor,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 82, 82, 82).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 14, color: AppColors.greyColor),
            ),
            Text(
              widget.subTitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textColorLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
