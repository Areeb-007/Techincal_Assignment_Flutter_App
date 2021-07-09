import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/api_response.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/widgets/list_view_widget.dart';

import '../main.dart';

class EmployeeDataForMainPage extends StatelessWidget {
  const EmployeeDataForMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Container(
      child: FutureBuilder(
          future: fetchEmployees(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data as List<Employee>)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
