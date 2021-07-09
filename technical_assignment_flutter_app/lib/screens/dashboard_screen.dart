import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/main.dart';
import 'package:technical_assignment_flutter_app/models/api_response.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/active_user_screen.dart';
import 'package:technical_assignment_flutter_app/screens/designation_screen.dart';
import 'package:technical_assignment_flutter_app/screens/employee_details_screesn.dart';
import 'package:technical_assignment_flutter_app/screens/user_info_screen.dart';

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
    APIResponse<List<Employee>> apiResponse =
        await Provider.of<Auth>(context, listen: false).getEmployeeData();
    if (apiResponse.error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyHome()));
                    },
                    child: Text('Go to Login page'))
              ],
              title: Text('Error'),
              content: Text(
                apiResponse.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            );
          });
    } else {
      list = apiResponse.data!;
    }

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
