class EndofDay {
  String studentId;
  String className;
  String breakfast;
  String lunch;
  String sleep;

  EndofDay({
    required this.studentId,
    required this.className,
    required this.breakfast,
    required this.lunch,
    required this.sleep,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    //map["id"] = id;
    map["studentId"] = studentId;
    map["className"] = className;
    map["breakfast"] = breakfast;
    map["lunch"] = lunch;
    map["sleep"] = sleep;
    return map;
  }

  EndofDay.fromMap(Map<String, dynamic> map)
      : studentId = map['studentId'],
        className = map['className'],
        breakfast = map['breakfast'],
        lunch = map['lunch'],
        sleep = map["sleep"];
}
