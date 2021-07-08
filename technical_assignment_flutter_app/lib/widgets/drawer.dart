import 'package:flutter/material.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
// import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/screens/dashboard_screen.dart';
import 'package:technical_assignment_flutter_app/screens/login_screen.dart';
import 'package:technical_assignment_flutter_app/screens/register_screen.dart';

class MainDrawer extends StatelessWidget {
  // final User user;
  final Future<List<Employee>> empList;
  MainDrawer(this.empList);

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
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Technical Assignment !',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Login',
            Icons.login,
            () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
        ],
      ),
    );
  }
}
