class Etkinlikler {
  int? id;
  String className;
  String eventName;
  String description;
  String startTime;
  String endTime;
  String eventStatus;

  Etkinlikler(
      {this.id,
      required this.className,
      required this.eventName,
      required this.description,
      required this.eventStatus,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    //map["id"] = id;
    map["className"] = className;
    map["eventName"] = eventName;
    map["description"] = description;
    map["eventStatus"] = eventStatus;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    return map;
  }

  Etkinlikler.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        className = map['className'],
        eventName = map['eventName'],
        description = map['description'],
        eventStatus = map["eventStatus"],
        startTime = map["startTime"],
        endTime = map["endTime"];
}
