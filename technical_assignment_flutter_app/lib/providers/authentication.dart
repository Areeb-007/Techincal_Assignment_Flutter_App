import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';

class Auth with ChangeNotifier {
  static const baseUrl = 'http://192.168.18.118:3000';
  String _token = '';
  List<Employee> empList = [];
  User user = User(
      userID: 12,
      firstName: 'firstName',
      lastName: 'lastName',
      username: 'username@email.com',
      password: 'password',
      address: 'address',
      phoneNumber: 'phoneNumber',
      isActice: true,
      isDeleted: false,
      createdBy: 'createdBy',
      createdOn: DateTime.now());
  // late DateTime _expiryDate;
  int _userID = -1;
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

      print(_token.isEmpty ? 'No token' : _userID);
      return true;
    }
  }

  //------------------------------------------SignUp---------------------------------------------------------//

  Future<bool> signUp(User user) async {
    print(jsonEncode(<String, Object>{
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
          'IsActive': user.isActice,
          'IsDeleted': user.isDeleted,
          'CreatedBy': user.createdBy,
          'CreatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        }));

    var responseBody = json.decode(response.body);
    print(responseBody);
    _token = responseBody['token'];
    _userID = responseBody['UserID'];
    print(_token.isEmpty ? 'No token' : _userID);

    String? msg = responseBody['msg'];

    if (msg != null && msg.isNotEmpty) {
      return false;
    } else {
      _token = json.decode(response.body)['token'];
      _userID = responseBody['UserID'];

      print(_token.isEmpty ? 'No token' : _userID);
      return true;
    }
  }

  //-----------------------------------------------------Add Employee-----------------------------------------
  Future<bool> addEmployee(Employee emp) async {
    print(jsonEncode(<String, Object>{
      'Name': emp.name,
      'Email': emp.email,
      'Age': emp.age,
      'Designation': emp.designation,
      'Gender': emp.gender,
      'DateOfBirth': DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.dateOfBirth),
      'IsActive': emp.isActive,
      'IsDeleted': emp.isDeleted,
      'CreatedBy': emp.createdBy,
      'CreatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    }));
    var response = await http.post(Uri.parse(baseUrl + '/rest/add'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(<String, Object>{
          // 'UserID': _userID as int,
          'Name': emp.name,
          'Email': emp.email,
          'Age': emp.age,
          'Designation': emp.designation,
          'Gender': emp.gender,
          'DateOfBirth':
              DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.dateOfBirth),
          'IsActive': emp.isActive,
          'IsDeleted': emp.isDeleted,
          'CreatedBy': emp.createdBy,
          'CreatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        }));

    var responseBody = json.decode(response.body);
    print(responseBody);
    String msg = responseBody['msg'];
    String msSc = responseBody['msg_sc'];
    print(msSc.isEmpty ? msg : 'done');
    if (msSc.isEmpty || msg.isNotEmpty) {
      return false;
    }
    if (msSc.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

//----------------------------------------------------get Employee Data------------------------------------

  Future<List<Employee>> getEmployeeData() async {
    print(_token);
    var response = await http.get(
      Uri.parse(baseUrl + '/rest/all'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token'
      },
    );
    if (response.statusCode != 200) {
      print('Token not Valid');
    }
    var rest = json.decode(response.body)['data'];
    List<Employee> list;
    list = rest.map<Employee>((json) => Employee.fromJson(json)).toList();
    empList = list.toList();
    return list;
  }

//---------------------------------------------------- Delete employee --------------------------------
  Future<bool> deleteEmployeeData(int id) async {
    print(id);
    var response = await http.patch(
      Uri.parse(baseUrl + '/rest/delete?id=$id'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token'
      },
    );
    if (response.statusCode != 200) {
      print('Token not Valid');
    }
    var responseBody = json.decode(response.body);
    String msg = responseBody['msg'];
    String msSc = responseBody['msg_sc'];
    print(msSc.isEmpty ? msg : 'done');
    if (msSc.isEmpty || msg.isNotEmpty) {
      return false;
    }
    if (msSc.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

//----------------------------------------Update Employee------------------------------------------------------
  Future<bool> updateEmployee(Employee emp) async {
    print(jsonEncode(<String, Object>{
      'Name': emp.name,
      'Email': emp.email,
      'Age': emp.age,
      'Designation': emp.designation,
      'Gender': emp.gender,
      'DateOfBirth': DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.dateOfBirth),
      'IsActive': emp.isActive,
      'IsDeleted': emp.isDeleted,
      'CreatedBy': emp.createdBy,
      'CreatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.createdOn),
      'UpdatedBy': emp.createdBy,
      'UpdatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
    }));
    var response = await http.put(
        Uri.parse(baseUrl + '/rest/update?id=${emp.empID}'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(<String, Object>{
          // 'UserID': _userID as int,
          'Name': emp.name,
          'Email': emp.email,
          'Age': emp.age,
          'Designation': emp.designation,
          'Gender': emp.gender,
          'DateOfBirth':
              DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.dateOfBirth),
          'IsActive': emp.isActive,
          'IsDeleted': emp.isDeleted,
          'CreatedBy': emp.createdBy,
          'CreatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.createdOn),
          'UpdatedBy': emp.createdBy,
          'UpdatedOn': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        }));

    var responseBody = json.decode(response.body);
    print(responseBody);
    String msg = responseBody['msg'];
    String msSc = responseBody['msg_sc'];
    print(msSc.isEmpty ? msg : 'done');
    if (msSc.isEmpty || msg.isNotEmpty) {
      return false;
    }
    if (msSc.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

//-------------------------------------------------Get User Data------------------------------------------

  Future<void> getUserData() async {
    var response = await http.get(
      Uri.parse(baseUrl + '/rest/dashboard'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token'
      },
    );
    if (response.statusCode != 200) {
      print('Token not Valid');
    }
    // user = json.decode(response.body)['data'];
    print(json.decode(response.body)['data']);
    var list = json.decode(response.body)['data'];
    List<User> usList = (list.map((usr) => User.fromJson(usr)).toList());
    // user = usList[0];
    print(usList[0]);
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
