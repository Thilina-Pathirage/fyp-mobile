import 'package:flutter/material.dart';
import 'package:fyp_mobile/widgets/common/custom_appbar.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => SsurveyScreenState();
}

class SsurveyScreenState extends State<SurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: 'Survey'),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ));
  }
}
