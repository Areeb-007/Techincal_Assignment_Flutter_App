import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';

class Auth with ChangeNotifier {
  static const baseUrl = 'http://192.168.18.118:3000';
  late String? _token;
  late DateTime _expiryDate;
  late int? _userID;

  String? get tokenValue {
    return _token;
  }

  //------------------------------------------SignIn---------------------------------------------------------//

  Future<bool> signin(String email, String password) async {
    var response;
    try {
      response = await http.post(Uri.parse(baseUrl + '/login/signin'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
            'Username': email,
            'Password': password,
          }));
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    print(json.decode(response.body));
    var responseBody = json.decode(response.body);
    String? msg = responseBody['msg'];

    if (msg != null && msg.isNotEmpty) {
      return false;
    } else {
      _token = json.decode(response.body)['token'];
      _userID = responseBody['UserID'];
      print(_token!.isEmpty ? 'No token' : _userID);
      return true;
    }
  }

  //------------------------------------------SignUp---------------------------------------------------------//

  Future<void> signUp(User user) async {
    var response = await http.post(Uri.parse(baseUrl + '/login/signup'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, Object>{
          'FirstName': user.firstName,
          'LastName': user.lastName,
          'Username': user.username,
          'Password': user.password,
          'Address': user.address,
          'PhoneNumber': user.phoneNumber,
          'IsActice': user.isActice,
          'IsDeleted': user.isDeleted,
          'CreatedBy': user.createdBy,
          'CreatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        }));
    var responseBody = json.decode(response.body);
    print(responseBody);
    _token = responseBody['token'];
    _userID = responseBody['UserID'];
    print(_token!.isEmpty ? 'No token' : _userID);
  }

//   Future<void> getData() async {
//     const url = 'http://192.168.18.118:3000/data';

//     print(_token);
//     var response = await http.get(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $_token'
//       },
//     );
//     if (response.statusCode != 200) {
//       print('Token not Valid');
//     }
//     print(json.decode(response.body));
//   }

}
