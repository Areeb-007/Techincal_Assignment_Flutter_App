// import 'dart:convert';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:technical_assignment_flutter_app/models/user.dart';

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

  Future<void> getData() async {
    // _formKey.currentState!.save();
    // postData();
    // await Provider.of<Auth>(context, listen: false).get_Data();
  }

  Future<void> _saveform() async {
    _formKey.currentState!.save();
    // postData();
    // await Provider.of<Auth>(context, listen: false)
    // .signUp(_editedUser.email, _editedUser.password);
  }

  void _onPressed() {
    // getData();
    // Provider.of<Auth>(context, listen: false).get_Data();
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
                      decoration: InputDecoration(labelText: 'Email'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid Email Pattern';
                        }
                        if (!value.contains('.com')) {
                          return 'Invalid Email Pattern';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // _editedUser = User(
                        //   email: value as String,
                        //   userID: _editedUser.userID,
                        //   password: _editedUser.password,
                        // );
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
                          // _editedUser = User(
                          //   email: _editedUser.email,
                          //   userID: _editedUser.userID,
                          //   password: value as String,
                          // );
                        }),
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
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: _onPressed, child: Text('Get Data'))
            ]),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
