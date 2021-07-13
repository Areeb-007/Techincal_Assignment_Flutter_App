// import 'dart:convert';
// import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:age/age.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/main.dart';

// import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'package:technical_assignment_flutter_app/screens/employee_data.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  AddEmployeeState createState() {
    return AddEmployeeState();
  }
}

//-------------------------------------------------Enum for gender------------------------------------------
enum GenderType { Male, Female, Other }

// Create a corresponding State class.
// This class holds data related to the form.
class AddEmployeeState extends State<AddEmployeeScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  int age = 0;
  int estimatedAge = 0;
  //---------------------------------------------Focus node goe changing the focus between textfields--------------------------------------
  final _addFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _designationFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();

  //-------------------------------------------------Controllers----------------------------------------------------------
  final ageTextFieldController = TextEditingController();

  //----------------------------------------------Disposing Focus Nodes For Optimization---------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _addFocusNode.dispose();
    _emailFocusNode.dispose();
    _ageFocusNode.dispose();
    _designationFocusNode.dispose();
    _genderFocusNode.dispose();
    _dateOfBirthFocusNode.dispose();
  }

  //----------------------------------------------Date Picker Modal---------------------------------------------------------
  void _showDateModal() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        dateOfBirth = value;
        DateTime today = DateTime.now();
        AgeDuration age2;
        age2 = Age.dateDifference(fromDate: dateOfBirth, toDate: today);
        age = age2.years;
        estimatedAge = age;
        ageTextFieldController.text = age.toString();
        _editedEmployee.setDateOfBirth = dateOfBirth!;
      });
    });
  }

//------------------------------------------------Drop Down firs Item----------------------------------------------------------
  String designation = 'Intern';

//------------------------------------------------Add An Employee Logic---------------------------------------------------------
  Future<void> _saveform() async {
    print(_editedEmployee.designation);
    _formKey.currentState!.save();
    String status = await Provider.of<Auth>(context, listen: false)
        .addEmployee(_editedEmployee);
    if (status == 'OK') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmployeeData()));
    } else if (status == 'Session time expired') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyHome()));
                    },
                    child: Text('Go to Login page'))
              ],
              title: Text('Error'),
              content: Text(
                status,
                style: TextStyle(color: Colors.red),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeeData()));
                    },
                    child: Text('Ok'))
              ],
              title: Text('Error'),
              content: Text(
                status,
                style: TextStyle(color: Colors.red),
              ),
            );
          });
    }
  }

//-------------------------------------------------Date of Birth Variable------------------------------------
  DateTime? dateOfBirth;
//--------------------------------------------------For gender-----------------------------------------------
  GenderType gender = GenderType.Male;

  var _editedEmployee = Employee(
      empID: -1,
      userID: 0,
      name: '',
      email: '',
      age: 0,
      designation: '',
      gender: 'Male',
      dateOfBirth: DateTime.now(),
      isActive: true,
      isDeleted: false,
      createdBy: '',
      createdOn: DateTime.now());

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Material(
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
                      decoration: InputDecoration(labelText: 'Name'),
                      // The validator receives the text that the user has entered.
                      // focusNode: _registerFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please a Name';
                        }
                      },
                      onSaved: (value) {
                        _editedEmployee = Employee(
                            empID: _editedEmployee.empID,
                            userID: _editedEmployee.userID,
                            name: value as String,
                            email: _editedEmployee.email,
                            age: _editedEmployee.age,
                            designation: _editedEmployee.designation,
                            gender: _editedEmployee.gender,
                            dateOfBirth: _editedEmployee.dateOfBirth,
                            isActive: _editedEmployee.isActive,
                            isDeleted: _editedEmployee.isDeleted,
                            createdBy: _editedEmployee.createdBy,
                            createdOn: _editedEmployee.createdOn);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      // The validator receives the text that the user has entered.
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        bool status = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value.toString());
                        return status ? null : 'Invalid Email';
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ageFocusNode);
                      },
                      onSaved: (value) {
                        _editedEmployee = Employee(
                            empID: _editedEmployee.empID,
                            userID: _editedEmployee.userID,
                            name: _editedEmployee.name,
                            email: value as String,
                            age: _editedEmployee.age,
                            designation: _editedEmployee.designation,
                            gender: _editedEmployee.gender,
                            dateOfBirth: _editedEmployee.dateOfBirth,
                            isActive: _editedEmployee.isActive,
                            isDeleted: _editedEmployee.isDeleted,
                            createdBy: _editedEmployee.createdBy,
                            createdOn: _editedEmployee.createdOn);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateOfBirth == null
                              ? 'Select Date Of Birth '
                              : DateFormat().add_yMMMd().format(dateOfBirth)),
                          TextButton(
                              focusNode: _dateOfBirthFocusNode,
                              onPressed: () => _showDateModal(),
                              child: Text('Choose A Date'))
                        ],
                      ),
                    ),
                    DropDownFormField(
                      titleText: 'Select a designation',
                      hintText: 'Please choose one',
                      value: designation,
                      contentPadding: EdgeInsets.all(5),
                      filled: true,
                      onSaved: (value) {
                        _editedEmployee = Employee(
                            empID: _editedEmployee.empID,
                            userID: _editedEmployee.userID,
                            name: _editedEmployee.name,
                            email: _editedEmployee.email,
                            age: _editedEmployee.age,
                            designation: value,
                            gender: _editedEmployee.gender,
                            dateOfBirth: _editedEmployee.dateOfBirth,
                            isActive: _editedEmployee.isActive,
                            isDeleted: _editedEmployee.isDeleted,
                            createdBy: _editedEmployee.createdBy,
                            createdOn: _editedEmployee.createdOn);
                      },
                      onChanged: (value) {
                        setState(() {
                          designation = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "Intern",
                          "value": "Intern",
                        },
                        {
                          "display": "SE",
                          "value": "SE",
                        },
                        {
                          "display": "ASE",
                          "value": "ASE",
                        },
                        {
                          "display": "SSE",
                          "value": "SSE",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                    Column(
                      children: <Widget>[
                        RadioListTile<GenderType>(
                          title: const Text('Male'),
                          value: GenderType.Male,
                          groupValue: gender,
                          onChanged: (GenderType? value) {
                            setState(() {
                              gender = value!;
                              print(gender);
                              _editedEmployee.genderType = 'Male';
                            });
                          },
                        ),
                        RadioListTile<GenderType>(
                          title: const Text('Female'),
                          value: GenderType.Female,
                          groupValue: gender,
                          onChanged: (GenderType? value) {
                            setState(() {
                              gender = value!;
                              print(gender);
                              _editedEmployee.genderType = 'Female';
                            });
                          },
                        ),
                        RadioListTile<GenderType>(
                          title: const Text('Other'),
                          value: GenderType.Other,
                          groupValue: gender,
                          onChanged: (GenderType? value) {
                            setState(() {
                              gender = value!;
                              print(gender);
                              _editedEmployee.genderType = 'Other';
                            });
                          },
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      // The validator receives the text that the user has entered.
                      controller: ageTextFieldController,
                      focusNode: _ageFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an age';
                        }
                        if (int.tryParse(value)! <= 0) {
                          return 'Please enter a valid age';
                        }
                        if (int.tryParse(value)! != estimatedAge) {
                          return 'Your does not match with your Date of Birth';
                        }
                        if (int.tryParse(value)! < 18) {
                          return 'Age must be above 18';
                        }
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_designationFocusNode);
                      },
                      onSaved: (value) {
                        _editedEmployee = Employee(
                            empID: _editedEmployee.empID,
                            userID: _editedEmployee.userID,
                            name: _editedEmployee.name,
                            email: _editedEmployee.email,
                            age: int.parse(value!),
                            designation: _editedEmployee.designation,
                            gender: _editedEmployee.gender,
                            dateOfBirth: _editedEmployee.dateOfBirth,
                            isActive: _editedEmployee.isActive,
                            isDeleted: _editedEmployee.isDeleted,
                            createdBy: _editedEmployee.createdBy,
                            createdOn: _editedEmployee.createdOn);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        focusNode: _addFocusNode,
                        onPressed: () {
                          print(_editedEmployee.isActive);
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            _saveform();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Add Employee'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeeData()));
                        },
                        child: Text('Back'),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
