class Payment {
//  int? id;
  String decontNo;
  String studentId;
  String payMonth;
  String payDate;
  String totalPay;
  String payStatus;

  Payment({
    //this.id,
    required this.decontNo,
    required this.studentId,
    required this.payMonth,
    required this.payDate,
    required this.totalPay,
    required this.payStatus,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    //map["id"] = id;
    map["decontNo"] = decontNo;
    map["studentId"] = studentId;
    map["payMonth"] = payMonth;
    map["payDate"] = payDate;
    map["totalPay"] = totalPay;
    map["payStatus"] = payStatus;

    return map;
  }

  Payment.fromMap(Map<String, dynamic> map)
      : decontNo = map['decontNo'],
        studentId = map['studentId'],
        payMonth = map['payMonth'],
        payDate = map['payDate'],
        totalPay = map['totalPay'],
        payStatus = map["payStatus"];
}
