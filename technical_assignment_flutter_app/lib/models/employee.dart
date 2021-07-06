// ignore: import_of_legacy_library_into_null_safe
// import 'package:intl/intl.dart';

class Employee {
  final int empID;
  final int userID;
  final String name;
  final String email;
  final int age;
  late final String designation;
  late String gender;
  DateTime dateOfBirth;
  final bool isActive;
  final bool isDeleted;
  final String createdBy;
  final DateTime createdOn;

  Employee({
    required this.empID,
    required this.userID,
    required this.name,
    required this.email,
    required this.age,
    required this.designation,
    required this.gender,
    required this.dateOfBirth,
    required this.isActive,
    required this.isDeleted,
    required this.createdBy,
    required this.createdOn,
  });

  set genderType(String gen) {
    this.gender = gen;
  }

  set setDateOfBirth(DateTime dob) {
    this.dateOfBirth = dob;
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empID: json['EmpID'],
      userID: json['UserID'],
      name: json['Name'],
      email: json['Email'],
      age: json['Age'],
      designation: json['Designation'],
      gender: json['Gender'],
      dateOfBirth: DateTime.parse(json['DateOfBirth']),
      isActive: json['IsActive'],
      isDeleted: json['IsDeleted'],
      createdBy: json['CreatedBy'],
      // createdOn: (DateTime.parse(json['CreatedOn']))
      createdOn: DateTime.now(),
    );
  }
}
