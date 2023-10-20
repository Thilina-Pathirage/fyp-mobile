import 'package:flutter/material.dart';
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
  List _healthTips = [];
  String _email = "";

  bool _isLoading = true;

  void _handleHealthData() async {
    final email = await _authService.getUserEmail();
    if (mounted) {
      setState(() {
        _email = email;
      });
    }
    final healthStatus = await _authService.getMentalStatus(email);
    final healthTips = await _authService.getUserMentalHealth(email);

    setState(() {
      _healthStatus = healthStatus;
      _healthTips = healthTips;
    });

    _isLoading = false;
  }

  // Future<void> _geEmail() async {
  //   try {
  //     final email = await _authService.getUserEmail();
  //     if (mounted) {
  //       setState(() {
  //         _email = email;
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _handleHealthData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: LoadingAnimationWidget.fallingDot(color: AppColors.primaryColor, size: 60))
        : Scaffold(
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
              automaticallyImplyLeading: false, // This hides the back button
              actions: [
                PopupMenuButton(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
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
            body: RefreshIndicator(
              onRefresh: () async {
                _handleHealthData();
              },
              child: SingleChildScrollView(
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const HomeStatCard(
                                          subTitle: 'Busy',
                                          title: 'Status',
                                          statBgColor: AppColors.secondaryColor,
                                        ),
                                        const SizedBox(width: 15.0),
                                        const HomeStatCard(
                                          subTitle: 'Havy',
                                          title: 'Workload',
                                          statBgColor: AppColors.secondaryColor,
                                        ),
                                        const SizedBox(width: 15.0),
                                        HomeStatCard(
                                          subTitle: _healthStatus,
                                          title: 'Health',
                                          statBgColor: AppColors.secondaryColor,
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
          );
  }
}
