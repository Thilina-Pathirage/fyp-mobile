import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';

class TipsPopup extends StatefulWidget {
  final List<dynamic> healthTips;

  const TipsPopup({super.key, required this.healthTips});

  @override
  State<TipsPopup> createState() => _TipsPopupState();
}

class _TipsPopupState extends State<TipsPopup> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Health Tips",
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        width: double.maxFinite,
        child: CarouselSlider(
          items: widget.healthTips.map((text) {
            return Center(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColorDark)),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}
