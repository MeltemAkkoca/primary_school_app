import 'package:meditation_app/models/user_authentication/users.dart';

class Teachers extends User {
  String className;

  Teachers(
      {required this.className,
      required super.userId,
      required super.password,
      required super.userName,
      required super.userSurname,
      required super.userRole,
      required super.phoneNumber});

  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map["className"] = className;
    return map;
  }

  Teachers.fromMap(Map<String, dynamic> map)
      : className = map['className'],
        super(
            userId: map['userId'],
            password: map['password'],
            userName: map['userName'],
            userSurname: map['userSurname'],
            userRole: map['userRole'],
            phoneNumber: map['phoneNumber']);
}
