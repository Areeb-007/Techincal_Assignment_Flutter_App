import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';

Widget userInfo(BuildContext context) {
  User currentUser = Provider.of<Auth>(context, listen: false).user;
  return Column(
    children: [
      Card(
        elevation: 8.0,
        shadowColor: Theme.of(context).primaryColorDark,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(2),
              leading: Icon(Icons.person),
              title: Text(currentUser.firstName),
              subtitle: Text(currentUser.lastName),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(2),
              leading: Icon(Icons.mail),
              title: Text(currentUser.username),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(2),
              leading: Icon(Icons.phone),
              title: Text(currentUser.phoneNumber),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(2),
              leading: Icon(Icons.home),
              title: Text(currentUser.phoneNumber),
            ),
          ],
        ),
      ),
    ],
  );
}
