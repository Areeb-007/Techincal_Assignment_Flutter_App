import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/dashboard_screen.dart';
import 'package:technical_assignment_flutter_app/screens/employee_data.dart';
// import 'package:technical_assignment_flutter_app/screens/employee_data.dart';
import 'package:technical_assignment_flutter_app/screens/update_screen.dart';

Widget listViewWidget(List<Employee> empList) {
  Future<void> callEmployeeDelete(BuildContext context, int empID) async {
    bool status = await Provider.of<Auth>(context, listen: false)
        .deleteEmployeeData(empID);
    if (status) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmployeeData()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Employee Deletion Failed'),
            );
          });
    }
  }

  void deleteData(BuildContext context, int iD) {
    print(iD);
    callEmployeeDelete(context, iD);
  }

  void updateData(BuildContext context, Employee emp) {
    print(emp.name);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateEmployeeScreen(
                  emp: emp,
                )));
  }

  return Container(
    child: ListView.builder(
        itemCount: empList.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              onTap: () => updateData(context, empList[position]),
              title: Text(
                '${empList[position].name}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              contentPadding: EdgeInsets.all(12),
              subtitle: Text(empList[position].designation),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteData(context, empList[position].empID),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                  height: 55.0,
                  width: 50.0,
                ),
              ),
            ),
          );
        }),
  );
}
