import 'package:flutter/material.dart';
import 'package:technical_assignment_flutter_app/screens/active_user_screen.dart';
import 'package:technical_assignment_flutter_app/screens/designation_screen.dart';
import 'package:technical_assignment_flutter_app/screens/employee_details_screesn.dart';
import 'package:technical_assignment_flutter_app/screens/user_info_screen.dart';

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool error = false;

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
            CurrentUserInfo(),
            ActiveUserScreen(),
            AllEmployeesInfo(),
            EmployeeDesignationInfo(),
          ],
        ),
      ),
    );
  }
}
