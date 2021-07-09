import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/widgets/user_info.dart';

class CurrentUserInfo extends StatelessWidget {
  const CurrentUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<User>> fetchUser() async {
      List<User> list = [
        // User(
        // userID: 1,
        // firstName: 'firstName',
        // lastName: 'lastName',
        // username: 'username',
        // password: 'password',
        // address: 'address',
        // phoneNumber: 'phoneNumber',
        // isActice: true,
        // isDeleted: false,
        // createdBy: 'createdBy',
        // createdOn: DateTime.now())
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

      list.add(await Provider.of<Auth>(context, listen: false)
          .getUserData()
          .then((value) => value[0]));
      print(list[0].username);
      return list;
    }

    return Container(
      child: FutureBuilder(
          future: fetchUser(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? userInfo(context, snapshot.data as List<User>)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
