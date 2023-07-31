import 'package:meditation_app/models/user_authentication/users.dart';

class Parents extends User {
  String studentId;

  Parents(
      {required this.studentId,
      required super.userId,
      required super.password,
      required super.userName,
      required super.userSurname,
      required super.userRole,
      required super.phoneNumber});

  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map["studentId"] = studentId;
    return map;
  }

  Parents.fromMap(Map<String, dynamic> map)
      : studentId = map['studentId'].toString(),
        super(
            userId: map['userId'],
            password: map['password'],
            userName: map['userName'],
            userSurname: map['userSurname'],
            userRole: map['userRole'],
            phoneNumber: map['phoneNumber']);
}
