// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:provider/provider.dart';

// import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
// import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
// import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/widgets/drawer.dart';
import 'package:technical_assignment_flutter_app/widgets/list_view_widget.dart';

import 'add_employee_screen.dart';

class EmployeeData extends StatefulWidget {
  const EmployeeData({Key? key}) : super(key: key);

  @override
  _EmployeeDataState createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  late Future<List<Employee>> empList;
  late User user;
  bool buffering = false;
  List<Employee> tempList = [];

  @override
  void initState() {
    super.initState();
    empList = fetchEmployees();
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
    list = await Provider.of<Auth>(context, listen: false).getEmployeeData();
    if (list.isEmpty) {
      setState(() {
        print("agia idher");
        buffering = true;
      });
    }
    tempList =
        await Provider.of<Auth>(context, listen: false).getEmployeeData();
    //print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home page')),
        drawer: MainDrawer(empList),
        body: Center(
          child: FutureBuilder(
              future: fetchEmployees(),
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? listViewWidget(snapshot.data as List<Employee>)
                    : Center(child: CircularProgressIndicator());
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AddEmployeeScreen())),
              child: Icon(Icons.add)),
        ));
  }
}
