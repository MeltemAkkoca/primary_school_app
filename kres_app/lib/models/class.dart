class Class {
  String className;

  Class({
    required this.className,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["className"] = className;
    return map;
  }

  Class.fromMap(Map<String, dynamic> map) : className = map['className'];
}
