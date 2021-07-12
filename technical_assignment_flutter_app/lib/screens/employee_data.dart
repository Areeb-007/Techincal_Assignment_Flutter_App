// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/main.dart';
import 'package:technical_assignment_flutter_app/models/api_response.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:provider/provider.dart';

// import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
// import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/emp_data_screen.dart';
// import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/widgets/drawer.dart';

import 'add_employee_screen.dart';

class EmployeeData extends StatefulWidget {
  const EmployeeData({Key? key}) : super(key: key);

  @override
  _EmployeeDataState createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  //late Future<List<Employee>> empList;
  late User user;
  bool buffering = false;
  List<Employee> tempList = [];

  @override
  void initState() {
    super.initState();
    // empList = fetchEmployees();
    print('Get Api Called from initState');
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
        actions: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEmployeeScreen()));
                },
                icon: Icon(Icons.add)),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EmployeeData())),
        child: Center(
          child: EmployeeDataForMainPage(),
        ),
      ),
    );
  }
}
