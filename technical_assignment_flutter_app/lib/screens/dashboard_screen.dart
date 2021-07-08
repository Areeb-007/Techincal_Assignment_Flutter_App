import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/widgets/active_users.dart';

import 'package:technical_assignment_flutter_app/widgets/user_info.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? errorMesssage;
  bool error = false;
  User user = User(
      userID: 1,
      firstName: 'firstName',
      lastName: 'lastName',
      username: 'username',
      password: 'password',
      address: 'address',
      phoneNumber: 'phoneNumber',
      isActice: true,
      isDeleted: false,
      createdBy: 'createdBy',
      createdOn: DateTime.now());

  Future<List<Employee>> fetchEmployees() async {
    List<Employee> list = [
      // Employee(
      //     empID: 12,
      //     userID: 12,
      //     name: 'name',
      //     email: 'email',
      //     age: 12,
      //     designation: 'designation',
      //     gender: 'gender',
      //     dateOfBirth: DateTime.now(),
      //     isActive: true,
      //     isDeleted: false,
      //     createdBy: 'createdBy',
      //     createdOn: DateTime.now()),
      // Employee(
      //     empID: 12,
      //     userID: 12,
      //     name: 'name',
      //     email: 'email',
      //     age: 12,
      //     designation: 'designation',
      //     gender: 'gender',
      //     dateOfBirth: DateTime.now(),
      //     isActive: true,
      //     isDeleted: false,
      //     createdBy: 'createdBy',
      //     createdOn: DateTime.now()),
    ];
    list = await Provider.of<Auth>(context, listen: false).getEmployeeData();
    //print(list);
    return list;
  }

  Future<List<User>> fetchUser() async {
    List<User> list = [
      // User(
      // userID: 1,
      // firstName: 'firstName',
      // lastName: 'lastName',
      // username: 'username',
      // password: 'password',
      // address: 'address',
      // phoneNumber: 'phoneNumber',
      // isActice: true,
      // isDeleted: false,
      // createdBy: 'createdBy',
      // createdOn: DateTime.now())
      // Employee(
      //     empID: 12,
      //     userID: 12,
      //     name: 'name',
      //     email: 'email',
      //     age: 12,
      //     designation: 'designation',
      //     gender: 'gender',
      //     dateOfBirth: DateTime.now(),
      //     isActive: true,
      //     isDeleted: false,
      //     createdBy: 'createdBy',
      //     createdOn: DateTime.now()),
    ];

    list.add(await Provider.of<Auth>(context, listen: false)
        .getUserData()
        .then((value) => value[0]));
    print(list[0].username);
    return list;
  }

  @override
  void initState() {
    super.initState();
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
            FutureBuilder(
                future: fetchUser(),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? userInfo(context, snapshot.data as List<User>)
                      : Center(child: CircularProgressIndicator());
                }),
            FutureBuilder(
                future: fetchEmployees(),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? acticeUsers(context, snapshot.data as List<Employee>)
                      : Center(child: CircularProgressIndicator());
                }),
            Icon(Icons.directions_bike),
            Icon(Icons.grass_sharp)
          ],
        ),
      ),
    );
  }
}
