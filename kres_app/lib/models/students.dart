class Students {
  String studentId;
  String studentFirstName;
  String studentLastName;
  String className;

  Students({
    required this.studentId,
    required this.studentFirstName,
    required this.studentLastName,
    required this.className,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["studentId"] = studentId;
    map["studentFirstName"] = studentFirstName;
    map["studentLastName"] = studentLastName;
    map["className"] = className;
    return map;
  }

  Students.fromMap(Map<String, dynamic> map)
      : studentId = map['studentId'] ?? "",
        studentFirstName = map['studentFirstName'] ?? "",
        studentLastName = map['studentLastName'] ?? "",
        className = map['className'] ?? "";
}
