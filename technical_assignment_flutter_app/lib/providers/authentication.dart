import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:technical_assignment_flutter_app/models/api_response.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';

class Auth with ChangeNotifier {
  static const baseUrl = 'http://192.168.18.118:3000';
  String msg = '';
  String msg_sc = '';
  String _token = '';
  List<Employee> empList = [];
  User user = User(
      userID: 1,
      firstName: 'firstName',
      lastName: 'lastName',
      username: 'username',
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

  Future<String> signin(String email, String password) async {
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
      return 'Server Not Availble';
    }
    print(json.decode(response.body));
    var responseBody = json.decode(response.body);
    msg = responseBody['msg'];
    msg_sc = responseBody['msg_sc'];
    if (msg.isNotEmpty) {
      return msg;
    } else {
      _token = json.decode(response.body)['token'];
      _userID = responseBody['UserID'];

      print(_token.isEmpty ? 'No token' : _userID);
      return 'OK';
    }
  }

  //------------------------------------------Make Token empty after logout-----------------------------------//
  void mmakeTokenNull() {
    _token = '';
  }

  //------------------------------------------SignUp---------------------------------------------------------//

  Future<String> signUp(User user) async {
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
    var response;
    try {
      response = await http.post(Uri.parse(baseUrl + '/login/signup'),
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
            'CreatedOn':
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          }));
    } catch (ex) {
      print(ex.toString());
      return 'Server Not Availble';
    }

    print(json.decode(response.body));
    var responseBody = json.decode(response.body);
    msg = responseBody['msg'];
    msg_sc = responseBody['msg_sc'];
    if (msg.isNotEmpty) {
      return msg;
    } else {
      _token = json.decode(response.body)['token'];
      _userID = responseBody['UserID'];

      print(_token.isEmpty ? 'No token' : _userID);
      return 'OK';
    }
  }

  //-----------------------------------------------------Add Employee-----------------------------------------
  Future<String> addEmployee(Employee emp) async {
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
    var response;
    try {
      response = await http.post(Uri.parse(baseUrl + '/rest/add'),
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
            'CreatedOn':
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          }));
    } catch (ex) {
      print(ex);
      return 'Server Not Available';
    }

    var responseBody = json.decode(response.body);
    print(responseBody);
    msg = responseBody['msg'];
    msg_sc = responseBody['msg_sc'];
    if (msg.isNotEmpty) {
      return msg;
    }
    return 'OK';
  }
//----------------------------------------------------get Employee Data------------------------------------

  Future<APIResponse<List<Employee>>> getEmployeeData() async {
    APIResponse<List<Employee>> apiResponse = APIResponse(errorMessage: '');
    List<Employee> list;
    var response;
    try {
      response = await http.get(
        Uri.parse(baseUrl + '/rest/all'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token'
        },
      );
    } catch (exc) {
      apiResponse.error = true;
      apiResponse.errorMessage = 'Server Not Availabe';
      return apiResponse;
    }
    var responseBody = json.decode(response.body);

    print(responseBody);
    msg = responseBody['msg'];
    msg_sc = responseBody['msg_sc'];
    if (msg.isNotEmpty) {
      apiResponse.error = true;
      mmakeTokenNull();
      apiResponse.errorMessage = msg;
      return apiResponse;
    }
    var rest = json.decode(response.body)['data'];
    list = rest.map<Employee>((json) => Employee.fromJson(json)).toList();
    empList = list.toList();

    apiResponse.error = false;
    apiResponse.errorMessage = '';
    apiResponse.data = list;
    return apiResponse;
  }

//---------------------------------------------------- Delete employee --------------------------------
  Future<String> deleteEmployeeData(int id) async {
    print(id);
    var response;
    try {
      response = await http.patch(
        Uri.parse(baseUrl + '/rest/delete?id=$id'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token'
        },
      );
    } catch (ex) {
      return 'Server Not Available';
    }
    var responseBody = json.decode(response.body);
    print(responseBody);
    msg = responseBody['msg'];
    msg_sc = responseBody['msg_sc'];
    if (msg.isNotEmpty) {
      return msg;
    }
    return 'OK';
  }

//----------------------------------------Update Employee------------------------------------------------------
  Future<String> updateEmployee(Employee emp) async {
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
    var response;
    try {
      response =
          await http.put(Uri.parse(baseUrl + '/rest/update?id=${emp.empID}'),
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
                'CreatedOn':
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(emp.createdOn),
                'UpdatedBy': emp.createdBy,
                'UpdatedOn':
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              }));
    } catch (ex) {
      print(ex.toString());
      return 'OK';
    }

    // String msg = responseBody['msg'];
    // String msSc = responseBody['msg_sc'];
    // print(msSc.isEmpty ? msg : 'done');
    // if (msSc.isEmpty || msg.isNotEmpty) {
    //   return false;
    // }
    // if (msSc.isNotEmpty) {
    //   return true;
    // } else {
    //   return false;
    // }
    var responseBody = json.decode(response.body);
    print(responseBody);
    msg = responseBody['msg'];
    msg_sc = responseBody['msg_sc'];
    if (msg.isNotEmpty) {
      return msg;
    }
    return 'OK';
  }

//-------------------------------------------------Get User Data------------------------------------------

  Future<List<User>> getUserData() async {
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
    var rest = json.decode(response.body)['data'];
    List<User> list;
    list = rest.map<User>((json) => User.fromJson(json)).toList();
    return list;
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
