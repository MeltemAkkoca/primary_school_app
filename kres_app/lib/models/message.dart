class Chatting {
  int? id;
  String senderId;
  String receiverId;
  String text;

  Chatting({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    //map["id"] = id;
    map["senderId"] = senderId;
    map["receiverId"] = receiverId;
    map["text"] = text;

    return map;
  }

  Chatting.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        senderId = map['senderId'],
        receiverId = map['receiverId'],
        text = map['text'];
}
