import 'package:flutter/material.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/themes/colors.dart';
import 'package:fyp_mobile/widgets/home/home_quick_access_block.dart';
import 'package:fyp_mobile/widgets/home/home_stat_card.dart';
import 'package:fyp_mobile/widgets/home/recent_leaves_block.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.primaryColor,
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 0, bottom: 26.0, left: 26.0, right: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good evening Thilina!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 242, 242, 242),
                          fontSize: 12),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20.0),
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HomeStatCard(
                                  subTitle: 'Busy',
                                  title: 'Status',
                                  statBgColor: AppColors.secondaryColor,
                                ),
                                SizedBox(width: 15.0),
                                HomeStatCard(
                                  subTitle: 'Havy',
                                  title: 'Workload',
                                  statBgColor: AppColors.secondaryColor,
                                ),
                                SizedBox(width: 15.0),
                                HomeStatCard(
                                  subTitle: 'Avarage',
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
            const Padding(
              padding: EdgeInsets.all(26.0),
              child: Column(
                children: [
                  HomeQuickAccessBlock(),
                  SizedBox(
                    height: 20,
                  ),
                  RecentLeavesBlock(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
