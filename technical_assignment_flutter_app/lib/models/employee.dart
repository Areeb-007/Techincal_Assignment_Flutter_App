class Employee {
  final int empID;
  final int userID;
  final String name;
  final String email;
  final int age;
  final String designation;
  final String gender;
  final DateTime dateOfBirth;

  Employee(
      {required this.empID,
      required this.userID,
      required this.name,
      required this.email,
      required this.age,
      required this.designation,
      required this.gender,
      required this.dateOfBirth});
}
