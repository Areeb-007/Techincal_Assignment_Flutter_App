import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userID;

  Future<void> signin(String email, String password) async {
    const url = 'http://192.168.18.118:3000/signin';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    print(json.decode(response.body));
    _token = json.decode(response.body)['token'];
    print(_token);
  }

  Future<void> signUp(String email, String password) async {
    const url = 'http://192.168.18.118:3000/signup';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    var responseBody = json.decode(response.body);
    print(responseBody);
    _token = responseBody['token'];
    _userID = responseBody['UserID'];
    print(_token);
  }

  Future<void> getData() async {
    const url = 'http://192.168.18.118:3000/data';

    print(_token);
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token'
      },
    );
    if (response.statusCode != 200) {
      print('Token not Valid');
    }
    print(json.decode(response.body));
  }
}
