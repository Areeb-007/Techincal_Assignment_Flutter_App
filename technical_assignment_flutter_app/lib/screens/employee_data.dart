import 'package:flutter/material.dart';
import 'package:technical_assignment_flutter_app/screens/add_employee_screen.dart';
import 'package:technical_assignment_flutter_app/widgets/drawer.dart';

class EmployeeData extends StatefulWidget {
  const EmployeeData({Key? key}) : super(key: key);

  @override
  _EmployeeDataState createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home page')),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            height: 300,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.lime,
                boxShadow: const [
                  BoxShadow(blurRadius: 10),
                ],
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: SingleChildScrollView(
              child: Text('Emplyee Data Will be here'),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEmployeeScreen())),
              child: Icon(Icons.add)),
        ));
  }
}
