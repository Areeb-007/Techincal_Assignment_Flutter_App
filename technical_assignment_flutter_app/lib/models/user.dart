class User {
  final int userID;
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String address;
  final String phoneNumber;
  final bool isActice;
  final bool isDeleted;
  final String createdBy;
  final DateTime createdOn;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.isActice,
    required this.isDeleted,
    required this.createdBy,
    required this.createdOn,
  });
}
