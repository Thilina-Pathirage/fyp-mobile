import 'package:flutter/material.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/widgets/common/custom_appbar.dart';
import 'package:fyp_mobile/widgets/common/main_btn.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'On a scale from 1 to 5, how would you rate your current workload?',
      'options': [
        'Very Manageable',
        'Manageable',
        'Neutral',
        'Overwhelming',
        'Extremely Overwhelming',
      ],
      'selectedOption': null, // Default answer
    },
    {
      'question':
          'How often do you find it difficult to balance your work responsibilities with your personal life?',
      'options': [
        'Never',
        'Rarely',
        'Sometimes',
        'Often',
        'Always',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How satisfied are you with your current job role and responsibilities?',
      'options': [
        'Very Satisfied',
        'Satisfied',
        'Neutral',
        'Dissatisfied',
        'Very Dissatisfied',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How would you describe your relationship with your colleagues and superiors?',
      'options': [
        'Very Positive',
        'Generally Positive',
        'Neutral',
        'Generally Negative',
        'Very Negative',
      ],
      'selectedOption': null,
    },
    {
      'question': 'How secure do you feel in your current job position?',
      'options': [
        'Very Secure',
        'Secure',
        'Neutral',
        'Insecure',
        'Very Insecure',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How often do you feel recognized and appreciated for your work?',
      'options': [
        'Always',
        'Often',
        'Sometimes',
        'Rarely',
        'Never',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How often do you resort to unhealthy coping mechanisms (e.g., excessive drinking, smoking, etc.) due to work stress?',
      'options': [
        'Never',
        'Rarely',
        'Sometimes',
        'Often',
        'Always',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How often do you experience physical symptoms (e.g., headaches, stomachaches) that you attribute to work stress?',
      'options': [
        'Never',
        'Rarely',
        'Sometimes',
        'Often',
        'Always',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How often do you feel mentally exhausted at the end of a workday?',
      'options': [
        'Never',
        'Rarely',
        'Sometimes',
        'Often',
        'Always',
      ],
      'selectedOption': null,
    },
    {
      'question':
          'How optimistic are you about the future of your career in the current company?',
      'options': [
        'Very Optimistic',
        'Optimistic',
        'Neutral',
        'Pessimistic',
        'Very Pessimistic',
      ],
      'selectedOption': null,
    },
  ];

  final _authService = AuthService();

  String _email = '';

  

  Future<void> _geEmail() async {
    try {
      final email = await _authService.getUserEmail();
      if (mounted) {
        setState(() {
          _email = email;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _handleSurvey() {
    // Check if all questions have been answered
    bool allQuestionsAnswered =
        questions.every((question) => question['selectedOption'] != null);

    if (allQuestionsAnswered) {
      // Collect the user's email and answers
      List<String> answers = questions.map<String>((question) {
        return question['selectedOption'];
      }).toList();

      // Call the submitSurvey function
      _authService
          .submitSurvey(
        email: _email,
        workload: answers[0],
        workLifeBalance: answers[1],
        jobSatisfaction: answers[2],
        interpersonalRelationships: answers[3],
        jobSecurity: answers[4],
        recognitionAndAppreciation: answers[5],
        copingMechanisms: answers[6],
        physicalSymptoms: answers[7],
        mentalFatigue: answers[8],
        jobFuture: answers[9],
      )
          .then((response) {
        // Handle the response here
        print('Survey submitted successfully: $response');
         Navigator.pushReplacementNamed(context, '/home');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Survey submitted successfully!"),
            backgroundColor: AppColors.primaryColor,
          ),
        );
      }).catchError((error) {
        // Handle errors
        print('Error submitting survey: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error submitting survey!"),
            backgroundColor: Colors.red,
          ),
        );
      });
    } else {
      // Inform the user to answer all questions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please answer all questions!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _geEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Survey'),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return _buildQuestion(index);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(26.0),
        child: MainBtn(
          title: 'Submit',
          btnColor: AppColors.primaryColor,
          onPressed: () {
            _handleSurvey();
          },
          txtColor: AppColors.textColorDark,
        ),
      ),
    );
  }

  Widget _buildQuestion(int index) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questions[index]['question'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            children: questions[index]['options'].map<Widget>((option) {
              return ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: questions[index]['selectedOption'],
                  onChanged: (value) {
                    setState(() {
                      questions[index]['selectedOption'] = value;
                      print(value);
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
