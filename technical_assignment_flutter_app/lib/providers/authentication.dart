import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:technical_assignment_flutter_app/models/user.dart';

class Auth with ChangeNotifier {
  static const baseUrl = 'http://192.168.18.118:3000';
  late String _token;
  late DateTime _expiryDate;
  late int _userID;

  Future<void> signin(String email, String password) async {
    var response = await http.post(Uri.parse(baseUrl + '/login/signin'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'Username': email,
          'Password': password,
        }));
    print(json.decode(response.body));
    var responseBody = json.decode(response.body);

    _token = json.decode(response.body)['token'];
    _userID = responseBody['user_id'];
    print(_token.isEmpty ? 'No token' : _userID);
  }

  Future<void> signUp(User user) async {
    var response = await http.post(Uri.parse(baseUrl + '/login/signup'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'FirstName': user.firstName,
          'LastName': user.lastName,
          'Username': user.username,
          'Password': user.password,
          'Address': user.address,
          'PhoneNumber': user.phoneNumber
        }));
    var responseBody = json.decode(response.body);
    print(responseBody);
    _token = responseBody['token'];
    _userID = responseBody['user_id'];
    print(_token.isEmpty ? 'No token' : _userID);
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
