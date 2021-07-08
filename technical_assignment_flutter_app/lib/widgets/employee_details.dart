import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';

Widget employeeInfo(BuildContext context, List<Employee> emp) {
  // User currentUser = Provider.of<Auth>(context, listen: false).getUserData().toString();
  return Container(
    child: ListView.builder(
        itemCount: emp.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            elevation: 8.0,
            shadowColor: Theme.of(context).primaryColorDark,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.star_half_sharp),
                  title: Text('Employee ID'),
                  subtitle: Text(emp[position].empID.toString()),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.emoji_people),
                  title: Text('Name'),
                  subtitle: Text(emp[position].name),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.mail),
                  title: Text('Email'),
                  subtitle: Text(emp[position].email),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.calendar_today),
                  title: Text('Age'),
                  subtitle: Text(emp[position].age.toString()),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.work),
                  title: Text('Designation'),
                  subtitle: Text(emp[position].designation),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.person),
                  title: Text('Gender'),
                  subtitle: Text(emp[position].gender),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.cake),
                  title: Text('Date Of Birth'),
                  subtitle: Text(DateFormat()
                      .add_yMMMd()
                      .format(emp[position].dateOfBirth)),
                ),
              ],
            ),
          );
        }),
  );
}
