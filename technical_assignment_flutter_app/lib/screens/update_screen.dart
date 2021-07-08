// import 'dart:convert';
// import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technical_assignment_flutter_app/models/employee.dart';
import 'package:technical_assignment_flutter_app/providers/authentication.dart';
import 'employee_data.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final Employee emp;
  UpdateEmployeeScreen({required this.emp});
  @override
  UpdateEmployeeState createState() {
    return UpdateEmployeeState(emp);
  }
}

//-------------------------------------------------Enum for gender------------------------------------------
enum GenderType { Male, Female, Other }

// Create a corresponding State class.
// This class holds data related to the form.
class UpdateEmployeeState extends State<UpdateEmployeeScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final Employee emp;
  UpdateEmployeeState(this.emp);
  //---------------------------------------------Focus node goe changing the focus between textfields--------------------------------------
  final _addFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _designationFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();

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
            initialDate: emp.dateOfBirth,
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        dateOfBirth = value;
        _editedEmployee.setDateOfBirth = dateOfBirth!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    designation = emp.designation;
    if (emp.gender == "Male") {
      gender = GenderType.Male;
    } else if (emp.gender == "Female") {
      gender = GenderType.Female;
    } else {
      gender = GenderType.Other;
    }
  }

//------------------------------------------------Drop Down firs Item----------------------------------------------------------
  String? designation;

//------------------------------------------------Add An Employee Logic---------------------------------------------------------
  Future<void> _saveform() async {
    print(_editedEmployee.designation);
    _formKey.currentState!.save();
    bool status = await Provider.of<Auth>(context, listen: false)
        .updateEmployee(_editedEmployee);
    if (status) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EmployeeData()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error',
                style: TextStyle(fontSize: 30),
              ),
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
              content: Text('Employee Updation Failed'),
            );
          });
    }
  }

  // GenderType? getGender() {
  //   GenderType? gen;
  //   switch (emp.gender) {
  //     case 'Male':
  //       {
  //         gen = GenderType.Male;
  //         print("male");
  //         return gen;
  //       }
  //     case 'Female':
  //       {
  //         gen = GenderType.Female;
  //         print("female");
  //         return gen;
  //       }

  //     case 'Other':
  //       {
  //         gen = GenderType.Other;
  //         print("male");
  //         return gen;
  //       }
  //   }
  //   return gen;
  // }

//-------------------------------------------------Date of Birth Variable------------------------------------
  DateTime? dateOfBirth;
//--------------------------------------------------For gender
  GenderType? gender;

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
    _editedEmployee = emp;
    dateOfBirth = emp.dateOfBirth;
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
                      initialValue: emp.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Name';
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
                      initialValue: emp.email,
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
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      // The validator receives the text that the user has entered.
                      focusNode: _ageFocusNode,
                      initialValue: emp.age.toString(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an age';
                        }
                        if (int.tryParse(value)! <= 0) {
                          return 'Please enter a valid age';
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
                    DropDownFormField(
                      titleText: 'Select a designation',
                      hintText: 'Please choose one',
                      value: emp.designation.toString(),
                      contentPadding: EdgeInsets.all(5),
                      // filled: true,
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
                    Row(
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
                    CheckboxListTileFormField(
                        title: Text('Is Active'),
                        initialValue: emp.isActive,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onSaved: (value) {
                          _editedEmployee = Employee(
                              empID: _editedEmployee.empID,
                              userID: _editedEmployee.userID,
                              name: _editedEmployee.name,
                              email: _editedEmployee.email,
                              age: _editedEmployee.age,
                              designation: _editedEmployee.designation,
                              gender: _editedEmployee.gender,
                              dateOfBirth: _editedEmployee.dateOfBirth,
                              isActive: value,
                              isDeleted: _editedEmployee.isDeleted,
                              createdBy: _editedEmployee.createdBy,
                              createdOn: _editedEmployee.createdOn);
                        }),
                    CheckboxListTileFormField(
                        title: Text('Is Deleted'),
                        initialValue: emp.isDeleted,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onSaved: (value) {
                          _editedEmployee = Employee(
                              empID: _editedEmployee.empID,
                              userID: _editedEmployee.userID,
                              name: _editedEmployee.name,
                              email: _editedEmployee.email,
                              age: _editedEmployee.age,
                              designation: _editedEmployee.designation,
                              gender: _editedEmployee.gender,
                              dateOfBirth: _editedEmployee.dateOfBirth,
                              isActive: _editedEmployee.isActive,
                              isDeleted: value,
                              createdBy: _editedEmployee.createdBy,
                              createdOn: _editedEmployee.createdOn);
                        }),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Creater'),
                      // The validator receives the text that the user has entered.
                      // focusNode: _registerFocusNode,
                      initialValue: emp.createdBy,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please a Creater name';
                        }
                      },
                      onSaved: (value) {
                        _editedEmployee = Employee(
                            empID: _editedEmployee.empID,
                            userID: _editedEmployee.userID,
                            name: _editedEmployee.name,
                            email: _editedEmployee.email,
                            age: _editedEmployee.age,
                            designation: _editedEmployee.designation,
                            gender: _editedEmployee.gender,
                            dateOfBirth: _editedEmployee.dateOfBirth,
                            isActive: _editedEmployee.isActive,
                            isDeleted: _editedEmployee.isDeleted,
                            createdBy: value as String,
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
                        child: Text('Update Employee'),
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
