// import 'dart:convert';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:technical_assignment_flutter_app/models/user.dart';
import 'package:technical_assignment_flutter_app/models/userLogin.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/employee_data.dart';
// import 'package:technical_assignment_flutter_app/widgets/drawer.dart';

// import 'package:http/http.dart' as http;

// Create a Form widget.
class LoginScreen extends StatefulWidget {
  Function changeBufferingStateToTrue = () {};
  LoginScreen(this.changeBufferingStateToTrue);
  @override
  LoginScreenState createState() {
    return LoginScreenState(changeBufferingStateToTrue);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginScreenState extends State<LoginScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  Function changeBufferingStateToTrue = () {};
  LoginScreenState(this.changeBufferingStateToTrue);
  final _formKey = GlobalKey<FormState>();
  bool buffering = false;

  Future<void> _saveform() async {
    _formKey.currentState!.save();
    bool status = await Provider.of<Auth>(context, listen: false)
        .signin(_editedUser.username, _editedUser.password);
    if (status) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmployeeData()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Error'),
              content: Text('Login Failed'),
            );
          });
    }
  }

  UserLogin _editedUser = UserLogin(
    username: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
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
                  decoration: InputDecoration(labelText: 'Email'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    bool status = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value.toString());
                    return status ? null : 'Invalid Email';
                  },
                  onSaved: (value) {
                    _editedUser = UserLogin(
                      username: value as String,
                      password: _editedUser.password,
                    );
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
                      if (value.length < 3) {
                        return 'Enter atleast 3 characters';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _editedUser = UserLogin(
                        username: _editedUser.username,
                        password: value as String,
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        // changeBufferingStateToTrue();
                        _saveform();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Log In'),
                  ),
                ),
              ],
            ),
          ),
          // ElevatedButton(onPressed: _onPressed, child: Text('Get Data'))
        ]),
      ),
    );
  }
}
