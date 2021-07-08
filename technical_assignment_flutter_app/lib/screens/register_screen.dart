// import 'dart:convert';
// import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';

import 'employee_data.dart';
// import 'package:checkbox_formfield/checkbox_formfield.dart';

// import 'package:http/http.dart' as http;

// Create a Form widget.
class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterScreenState extends State<RegisterScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _lastNameFocusNode = FocusNode();
  final _username = FocusNode();
  final _password = FocusNode();
  final _address = FocusNode();
  final _phoneNumber = FocusNode();
  final _register = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _lastNameFocusNode.dispose();
    _username.dispose();
    _password.dispose();
    _address.dispose();
    _phoneNumber.dispose();
    _register.dispose();
  }

  Future<void> _saveform() async {
    _formKey.currentState!.save();
    bool status =
        await Provider.of<Auth>(context, listen: false).signUp(_editedUser);
    if (status) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmployeeData()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Sign up Failed'),
            );
          });
    }
  }

  var _editedUser = User(
      userID: -1,
      firstName: '',
      lastName: '',
      username: '',
      password: '',
      address: '',
      phoneNumber: '',
      isActice: true,
      isDeleted: false,
      createdBy: '',
      createdOn: DateTime.now());
  bool buffering = true;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return buffering
        ? Material(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'First Name'),
                            // The validator receives the text that the user has entered.
                            // focusNode: _registerFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lastNameFocusNode);
                            },
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: value as String,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Last Name'),
                            // The validator receives the text that the user has entered.
                            focusNode: _lastNameFocusNode,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_username);
                            },
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: value as String,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Username'),
                            // The validator receives the text that the user has entered.
                            focusNode: _username,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              bool status = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value.toString());
                              return status ? null : 'Invalid Email';
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_password);
                            },
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: value as String,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            // The validator receives the text that the user has entered.
                            focusNode: _password,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_address);
                            },
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: value as String,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Address'),
                            // The validator receives the text that the user has entered.
                            maxLines: 3,
                            focusNode: _address,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_phoneNumber);
                            },
                            keyboardType: TextInputType.multiline,
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: value as String,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Phone Number'),
                            textInputAction: TextInputAction.next,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Number';
                              }
                            },
                            focusNode: _phoneNumber,
                            // onFieldSubmitted: (_) {
                            //   FocusScope.of(context).requestFocus(_register);
                            // },
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: value as String,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          CheckboxListTileFormField(
                            title: Text('Is Active'),
                            initialValue: true,
                            controlAffinity: ListTileControlAffinity.trailing,
                            onSaved: (bool value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: value,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          CheckboxListTileFormField(
                            title: Text('Is Deleted'),
                            initialValue: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            onSaved: (bool value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: value,
                                  createdBy: _editedUser.createdBy,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Creator Name'),
                            textInputAction: TextInputAction.next,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Creater Name';
                              }
                            },
                            // focusNode: _phoneNumber,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_register);
                            },
                            onSaved: (value) {
                              _editedUser = User(
                                  userID: 0,
                                  firstName: _editedUser.firstName,
                                  lastName: _editedUser.lastName,
                                  username: _editedUser.username,
                                  password: _editedUser.password,
                                  address: _editedUser.address,
                                  phoneNumber: _editedUser.phoneNumber,
                                  isActice: _editedUser.isActice,
                                  isDeleted: _editedUser.isDeleted,
                                  createdBy: value as String,
                                  createdOn: _editedUser.createdOn);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              focusNode: _register,
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  _saveform();
                                  setState(() {
                                    buffering = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Processing Data')));
                                }
                              },
                              child: Text('Register'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
