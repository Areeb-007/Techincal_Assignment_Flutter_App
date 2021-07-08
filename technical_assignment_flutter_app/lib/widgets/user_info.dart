import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';

Widget userInfo(BuildContext context, List<User> user) {
  // User currentUser = Provider.of<Auth>(context, listen: false).getUserData().toString();
  return Container(
    child: ListView.builder(
        itemCount: user.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            elevation: 8.0,
            shadowColor: Theme.of(context).primaryColorDark,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.person),
                  title: Text(user[position].firstName),
                  subtitle: Text(user[position].lastName),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.mail),
                  title: Text(user[position].username),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.phone),
                  title: Text(user[position].phoneNumber),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(2),
                  leading: Icon(Icons.home),
                  title: Text(user[position].address == null
                      ? 'Not Available'
                      : user[position].address),
                ),
              ],
            ),
          );
        }),
  );
}
