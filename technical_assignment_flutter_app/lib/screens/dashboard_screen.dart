import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/widgets/active_users.dart';

import 'package:technical_assignment_flutter_app/widgets/user_info.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> getUser() async {
    await Provider.of<Auth>(context, listen: false).getUserData();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.verified_user_outlined),
                text: 'User Info',
              ),
              Tab(
                icon: Icon(Icons.emoji_people),
                text: 'Active',
              ),
              Tab(
                icon: Icon(Icons.list_sharp),
                text: 'All',
              ),
              Tab(
                icon: Icon(Icons.auto_graph),
                text: 'Designations',
              ),
            ],
          ),
          title: Text('Dashboard'),
        ),
        body: TabBarView(
          children: [
            userInfo(context),
            acticeUsers(),
            Icon(Icons.directions_bike),
            Icon(Icons.grass_sharp)
          ],
        ),
      ),
    );
  }
}
