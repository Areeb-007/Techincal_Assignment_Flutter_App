class User {
  final int userID;
  final String firstName;
  final String lastName;
  final String username;
  final String password;
  final String address;
  final String phoneNumber;

  User(
      {required this.userID,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.password,
      required this.address,
      required this.phoneNumber});
}
