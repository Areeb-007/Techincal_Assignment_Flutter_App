import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/employee_data.dart';

Widget listViewWidget(List<Employee> empList) {
  Future<void> callEmployeeDelete(BuildContext context, int empID) async {
    bool status = await Provider.of<Auth>(context, listen: false)
        .deleteEmployeeData(empID);
    if (status) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EmployeeData()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Employee Didnt Deleted'),
            );
          });
    }
  }

  void deleteData(BuildContext context, int iD) {
    print(iD);
    callEmployeeDelete(context, iD);
  }

  return Container(
    child: ListView.builder(
        itemCount: empList.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
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
                  child: Icon(Icons.person),
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ),
          );
        }),
  );
}
