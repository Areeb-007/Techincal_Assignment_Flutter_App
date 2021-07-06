class Employee {
  final int empID;
  final int userID;
  final String name;
  final String email;
  final int age;
  late final String designation;
  late final String gender;
  final DateTime dateOfBirth;
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
}
