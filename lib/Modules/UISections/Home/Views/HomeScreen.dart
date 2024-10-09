import 'package:flutter/material.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Views/DashboardScreen.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieSearch/Views/MovieSearchScreen.dart';
import 'package:movie_hub/Modules/UISections/Settings/Views/SettingScreen.dart';

import '../../TabBar/Model/TabItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: TabItem.values.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: makeTabBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          DashboardScreen(),
          MovieSearchScreen(),
          SettingScreen(),
        ],
      ),
    );
  }

  Widget makeTabBar() {
    return Container(
      color: Colors.white54,
      child: TabBar(
        controller: _tabController,
        indicatorPadding: const EdgeInsets.only(bottom: 4),
        tabs: [
          Tab(
            text: TabItem.home.getTitle(),
            icon: const Icon(Icons.home),
          ),
          Tab(
            text: TabItem.search.getTitle(),
            icon: const Icon(Icons.search),
          ),
          Tab(
            text: TabItem.setting.getTitle(),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
