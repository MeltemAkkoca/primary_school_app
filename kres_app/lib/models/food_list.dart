class FoodList {
  int? id;
  String className;
  String tarih;
  String saat;
  String food1;
  String food2;
  String food3;
  String food4;

  FoodList({
    this.id,
    required this.className,
    required this.tarih,
    required this.saat,
    required this.food1,
    required this.food2,
    required this.food3,
    required this.food4,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    //map["id"] = id;
    map["className"] = className;
    map["tarih"] = tarih;
    map["saat"] = saat;
    map["food1"] = food1;
    map["food2"] = food2;
    map["food3"] = food3;
    map["food4"] = food4;

    return map;
  }

  FoodList.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        className = map['className'],
        tarih = map['tarih'],
        saat = map['saat'],
        food1 = map['food1'],
        food2 = map["food2"],
        food3 = map["food3"],
        food4 = map["food4"];
}
