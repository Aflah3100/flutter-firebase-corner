class UserModel {
  String firstName;
  String lastName;
  int age;

  UserModel(
      {required this.firstName, required this.lastName, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['FirstName'] ?? '',
      lastName: map['LastName'] ?? '',
      age: map['Age'] ?? 0,
    );
  }
}
