import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';

Widget user2Info(BuildContext context, User user) {
  return Card(
    elevation: 8.0,
    shadowColor: Theme.of(context).primaryColorDark,
    child: Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(2),
          leading: Icon(Icons.person),
          title: Text(user.firstName),
          subtitle: Text(user.lastName),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(2),
          leading: Icon(Icons.mail),
          title: Text(user.username),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(2),
          leading: Icon(Icons.phone),
          title: Text(user.phoneNumber),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(2),
          leading: Icon(Icons.home),
          title: Text(user.address),
        ),
      ],
    ),
  );
}
