class User {
  String userId;
  String password;
  String userName;
  String userSurname;
  String userRole;
  String phoneNumber;

  User(
      {required this.userId,
      required this.password,
      required this.userName,
      required this.userSurname,
      required this.userRole,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["password"] = password;
    map["userName"] = userName;
    map["userSurname"] = userSurname;
    map["userRole"] = userRole;
    map["phoneNumber"] = phoneNumber;
    return map;
  }

  User.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        password = map['password'],
        userName = map['userName'],
        userSurname = map["userSurname"],
        userRole = map["userRole"],
        phoneNumber = map["phoneNumber"];
}
