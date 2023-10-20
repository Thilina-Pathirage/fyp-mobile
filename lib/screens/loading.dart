import 'package:flutter/material.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: LoadingAnimationWidget.fallingDot(
          color: AppColors.primaryColor,
          size: 60,
        ),
      ),
    );
  }
}
