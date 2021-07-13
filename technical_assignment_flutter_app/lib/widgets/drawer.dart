import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/main.dart';
import 'package:technical_assignment_flutter_app/models/api_response.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/dashboard_screen.dart';
import 'package:technical_assignment_flutter_app/screens/register_screen.dart';

class MainDrawer extends StatefulWidget {
  // final User user;

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // late Future<List<Employee>> empList;
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
  void initState() {
    super.initState();
    //empList = fetchEmployees();
    print('Get Api Called from initState');
  }

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Technical Assignment !',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(
              'Login',
              Icons.login,
              () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyHome()));
              },
            ),
            buildListTile(
              'Register',
              Icons.app_registration_outlined,
              () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            ),
            buildListTile(
              'Dashboard',
              Icons.dashboard,
              () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
            ),
            buildListTile(
              'Logout',
              Icons.logout,
              () {
                Provider.of<Auth>(context, listen: false).mmakeTokenNull();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyHome()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
