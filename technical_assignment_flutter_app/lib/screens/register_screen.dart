// import 'dart:convert';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';

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

  Future<void> _saveform() async {
    _formKey.currentState!.save();
    await Provider.of<Auth>(context, listen: false).signUp(_editedUser);
  }

  var _editedUser = User(
      userID: 0,
      firstName: '',
      lastName: '',
      username: '',
      password: '',
      address: '',
      phoneNumber: '');

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form'),
        ),
        body: Container(
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
                      decoration: InputDecoration(labelText: 'First Name'),
                      // The validator receives the text that the user has entered.
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
                            phoneNumber: _editedUser.phoneNumber);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Last Name'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      onSaved: (value) {
                        _editedUser = User(
                            userID: 0,
                            firstName: _editedUser.firstName,
                            lastName: value as String,
                            username: _editedUser.username,
                            password: _editedUser.password,
                            address: _editedUser.address,
                            phoneNumber: _editedUser.phoneNumber);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      onSaved: (value) {
                        _editedUser = User(
                            userID: 0,
                            firstName: _editedUser.firstName,
                            lastName: _editedUser.lastName,
                            username: value as String,
                            password: _editedUser.password,
                            address: _editedUser.address,
                            phoneNumber: _editedUser.phoneNumber);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      // The validator receives the text that the user has entered.
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedUser = User(
                            userID: 0,
                            firstName: _editedUser.firstName,
                            lastName: _editedUser.lastName,
                            username: _editedUser.username,
                            password: value as String,
                            address: _editedUser.address,
                            phoneNumber: _editedUser.phoneNumber);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address'),
                      // The validator receives the text that the user has entered.
                      onSaved: (value) {
                        _editedUser = User(
                            userID: 0,
                            firstName: _editedUser.firstName,
                            lastName: _editedUser.lastName,
                            username: _editedUser.username,
                            password: _editedUser.password,
                            address: value as String,
                            phoneNumber: _editedUser.phoneNumber);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Number';
                        }
                      },
                      onSaved: (value) {
                        _editedUser = User(
                            userID: 0,
                            firstName: _editedUser.firstName,
                            lastName: _editedUser.lastName,
                            username: _editedUser.username,
                            password: _editedUser.password,
                            address: _editedUser.address,
                            phoneNumber: value as String);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            _saveform();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
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
      debugShowCheckedModeBanner: false,
    );
  }
}
