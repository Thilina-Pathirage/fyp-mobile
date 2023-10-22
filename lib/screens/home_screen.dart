import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/widgets/home/home_quick_access_block.dart';
import 'package:fyp_mobile/widgets/home/home_stat_card.dart';
import 'package:fyp_mobile/widgets/home/recent_leaves_block.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();

  String _healthStatus = 'N/A';
  String _workLoad = 'N/A';
  List _healthTips = [];
  String _email = "";
  String _workStatus = "N/A";

  bool _isLoading = true;

  void _handleHealthData() async {
    _isLoading = true;

    final email = await _authService.getUserEmail();
    if (mounted) {
      setState(() {
        _email = email;
      });
    }
    final healthStatus = await _authService.getMentalStatus(email);
    final workLoad = await _authService.getWorkLoad(email);
    final healthTips = await _authService.getUserMentalHealth(email);
    final workStatus = await _authService.getWorkStatus(email);

    setState(() {
      _healthStatus = healthStatus;
      _workLoad = workLoad;
      _healthTips = healthTips;
      _workStatus = workStatus;
    });

    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _handleHealthData();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit Eudaimonia'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Color getHealthStatusColor(String status) {
    switch (status) {
      case 'Normal':
        return const Color.fromARGB(255, 191, 255, 193);
      case 'Mild':
        return const Color.fromARGB(255, 255, 250, 209);
      case 'Moderate':
        return const Color.fromARGB(255, 255, 239, 215);
      case 'Severe':
        return const Color.fromARGB(255, 255, 229, 227);
      case 'Extremely Severe':
        return const Color.fromARGB(255, 255, 182, 182);
      default:
        return Colors.white; // Default color or handle unknown status here
    }
  }

  Color getWorkloadStatusColor(String status) {
    switch (status) {
      case 'Light':
        return const Color.fromARGB(255, 191, 255, 193);

      case 'Moderate':
        return const Color.fromARGB(255, 255, 250, 209);
      case 'Normal':
        return const Color.fromARGB(255, 255, 239, 215);
      case 'Severe':
      case 'Heavy':
        return const Color.fromARGB(255, 255, 229, 227);
      case 'Overload':
        return const Color.fromARGB(255, 255, 182, 182);
      default:
        return Colors.white; // Default color or handle unknown status here
    }
  }

    Color getWorStatusColor(String status) {
    switch (status) {
      case 'Online':
        return const Color.fromARGB(255, 191, 255, 193);

      case 'Offline':
        return const Color.fromARGB(255, 227, 227, 227);
      default:
        return Colors.white; // Default color or handle unknown status here
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: AppColors.secondaryColor,
            child: Center(
                child: LoadingAnimationWidget.fallingDot(
                    color: AppColors.primaryColor, size: 60)),
          )
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: RefreshIndicator(
              onRefresh: () async {
                _handleHealthData();
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  title: const Text(
                    'Eudaimonia',
                    style: TextStyle(
                      color: AppColors.textColorDark,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  automaticallyImplyLeading:
                      false, // This hides the back button
                  actions: [
                    PopupMenuButton(
                      icon:
                          const Icon(Icons.account_circle, color: Colors.white),
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Logout'),
                          ),
                        ];
                      },
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            _authService.logout(context);
                        }
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 26.0, left: 26.0, right: 26.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User: $_email',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 242, 242, 242),
                                    fontSize: 12),
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 20.0),
                                  Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          HomeStatCard(
                                            subTitle: _healthStatus,
                                            title: 'Health',
                                            statBgColor: getHealthStatusColor(
                                                _healthStatus),
                                          ),
                                          const SizedBox(width: 15.0),
                                          HomeStatCard(
                                            subTitle: _workLoad,
                                            title: 'Workload',
                                            statBgColor:
                                                getWorkloadStatusColor(_workLoad),
                                          ),
                                          const SizedBox(width: 15.0),
                                          HomeStatCard(
                                            subTitle: _workStatus,
                                            title: 'Status',
                                            statBgColor:
                                                getWorStatusColor(_workStatus),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Column(
                          children: [
                            HomeQuickAccessBlock(healthTips: _healthTips),
                            const SizedBox(
                              height: 20,
                            ),
                            const RecentLeavesBlock(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
