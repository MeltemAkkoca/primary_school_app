//import 'package:meditation_app/models/class.dart';
import 'package:meditation_app/models/%C3%B6deme.dart';
import 'package:meditation_app/models/end_of_day.dart';
import 'package:meditation_app/models/message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/models/user_authentication/parents.dart';
import 'package:meditation_app/models/user_authentication/users.dart';
import 'package:meditation_app/models/students.dart';
import 'package:meditation_app/models/etkinlikler.dart';
import '../food_list.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _theDb;

  Future<Database> get theDb async {
    if (_theDb != null) {
      return _theDb!;
    }
    _theDb = await setDb();
    return _theDb!;
  }

  DatabaseHelper.internal();

  setDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "theDb");
    var theDb = await openDatabase(path,
        version: 12, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onUpgrade(Database theDb, int oldVersion, int newVersion) async {
    // Drop the existing tables
    await theDb.execute('DROP TABLE IF EXISTS Teachers');
    await theDb.execute('DROP TABLE IF EXISTS Students');
    await theDb.execute('DROP TABLE IF EXISTS Parents');
    await theDb.execute('DROP TABLE IF EXISTS Etkinlikler');
    await theDb.execute('DROP TABLE IF EXISTS FoodList');
    await theDb.execute('DROP TABLE IF EXISTS Payment');
    await theDb.execute('DROP TABLE IF EXISTS EndofDay');
    await theDb.execute('DROP TABLE IF EXISTS Chatting');

    // Call _onCreate to recreate the tables
    _onCreate(theDb, newVersion);
  }

  void _onCreate(Database theDb, int version) async {
    await theDb.execute('''
    CREATE TABLE Teachers(
      userId TEXT PRIMARY KEY,
      password TEXT,
      userName TEXT,
      userSurname TEXT,
      userRole TEXT,
      phoneNumber TEXT,
      className TEXT
    )
  ''');
    //await theDb.execute("CREATE TABLE Class(className TEXT PRIMARY KEY)");

    await theDb.execute(
        "CREATE TABLE Students(studentId TEXT PRIMARY KEY, studentFirstName TEXT, studentLastName TEXT, className TEXT, FOREIGN KEY(studentId) REFERENCES EndofDay(studentId))");

    await theDb.execute(
        "CREATE TABLE Parents(userId TEXT PRIMARY KEY, password TEXT, userName TEXT, userSurname TEXT, userRole TEXT, phoneNumber TEXT, studentId TEXT, FOREIGN KEY(studentId) REFERENCES Students(studentId))");
    await theDb.execute(
        '''CREATE TABLE Etkinlikler( id INTEGER PRIMARY KEY AUTOINCREMENT, eventName TEXT, description TEXT, className TEXT,  startTime TEXT, endTime TEXT, eventStatus TEXT)''');
    await theDb.execute(
        '''CREATE TABLE FoodList( id INTEGER PRIMARY KEY AUTOINCREMENT, className TEXT, tarih TEXT, saat Text, food1 TEXT, food2 TEXT,  food3 TEXT, food4 TEXT)''');
    await theDb.execute('''CREATE TABLE Payment(
  decontNo TEXT PRIMARY KEY,
  studentId TEXT,
  payMonth TEXT,
  payDate TEXT,
  totalPay TEXT,
  payStatus TEXT,
  FOREIGN KEY(studentId) REFERENCES Students(studentId))
''');

    await theDb.execute(
        '''CREATE TABLE EndofDay( studentId TEXT PRIMARY KEY, className TEXT, breakfast TEXT, lunch TEXT, sleep TEXT,FOREIGN KEY(studentId) REFERENCES Students(studentId))''');
    await theDb.execute(
        '''CREATE TABLE Chatting( id INTEGER PRIMARY KEY AUTOINCREMENT, senderId TEXT, receiverId TEXT, text TEXT)''');
    var res = await theDb
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    print("Tables");
    print(res);

    var pay1 = Payment(
        decontNo: "90871",
        studentId: "91235421056",
        payMonth: "Mayıs",
        payDate: "14 Mayıs 2023",
        totalPay: "300 tl",
        payStatus: "Ödendi");
    await theDb.insert("Payment", pay1.toMap());

    var teacher1 = Teachers(
        userId: "37986278343",
        password: "password1",
        userName: "teacher1",
        userSurname: "surname1",
        userRole: "teacher",
        phoneNumber: "1234567890",
        className: "Çiçek");

    var teacher2 = Teachers(
        userId: "5447303967",
        password: "p2",
        userName: "teacher2",
        userSurname: "surname2",
        userRole: "teacher",
        phoneNumber: "1234567890",
        className: "Papatya");

    //var class1 = Class(className: "Papatya");
    await theDb.insert("Teachers", teacher1.toMap());
    await theDb.insert("Teachers", teacher2.toMap());

    //await theDb.insert("Class", class1.toMap());

    var student1 = Students(
        studentId: "91235421056",
        studentFirstName: "Merve Nur",
        studentLastName: "Ozan",
        className: "Papatya");

    var student2 = Students(
        studentId: "56874275287",
        studentFirstName: "Merter",
        studentLastName: "Çoban",
        className: "Papatya");

    var student3 = Students(
        studentId: "56712395445",
        studentFirstName: "Meltem",
        studentLastName: "Akkoca",
        className: "Papatya");

    await theDb.insert("Students", student1.toMap());
    await theDb.insert("Students", student2.toMap());
    await theDb.insert("Students", student3.toMap());

    var parent1 = Parents(
        userId: "4822319619336",
        password: "password2",
        userName: "Hülya",
        userSurname: "Ozan",
        userRole: "parent",
        phoneNumber: "1234567890",
        studentId: "91235421056");

    var parent2 = Parents(
        userId: "52568268384",
        password: "p3",
        userName: "Yunus",
        userSurname: "Ozan",
        userRole: "parent",
        phoneNumber: "9876512897",
        studentId: "91235421056");

    var parent3 = Parents(
        userId: "78945612378",
        password: "p4",
        userName: "Sezai",
        userSurname: "Yerebakan",
        userRole: "parent",
        phoneNumber: "12547896634",
        studentId: "56874275287");
    var parent4 = Parents(
        userId: "23981365434",
        password: "p5",
        userName: "Ahmet",
        userSurname: "Akkoca",
        userRole: "parent",
        phoneNumber: "8573819783",
        studentId: "56712395445");

    await theDb.insert("Parents", parent1.toMap());
    await theDb.insert("Parents", parent2.toMap());
    await theDb.insert("Parents", parent3.toMap());
    await theDb.insert("Parents", parent4.toMap());
  }

  Future<User?> getUser(String userId, String password) async {
    var dbClient = await theDb;
    List<Map> result;

    result = await dbClient.rawQuery(
        'SELECT * FROM Teachers WHERE userId = ? and password = ?',
        [userId, password]);

    if (result.length > 0) {
      return Teachers.fromMap(result.first as Map<String, dynamic>);
    }

    result = await dbClient.rawQuery(
        'SELECT * FROM Parents WHERE userId = ? and password = ?',
        [userId, password]);

    if (result.length > 0) {
      return Parents.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<Teachers?> getTeacher(User user) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient
        .rawQuery('SELECT * FROM Teachers WHERE userId = ?', [user.userId]);

    if (result.length > 0) {
      return Teachers.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<Parents?> getParent(User user) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient
        .rawQuery('SELECT * FROM Parents WHERE userId = ?', [user.userId]);

    if (result.length > 0) {
      return Parents.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<Students?> getStudentClassNamebyParent(Parents parent) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient.rawQuery(
        'SELECT S.className FROM Parents as P JOIN  Students as S ON P.studentId = S.studentId WHERE P.userId = ?',
        [parent.userId]);

    if (result.length > 0) {
      return Students.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<int> insertEtkinlik(Etkinlikler etkinlik) async {
    var dbClient = await theDb;
    return await dbClient.insert('Etkinlikler', etkinlik.toMap());
  }

  Future<List<Etkinlikler>> loadEtkinlikler(String className) async {
    var dbClient = await theDb;
    var result = await dbClient
        .query('etkinlikler', where: 'className = ?', whereArgs: [className]);
    List<Etkinlikler> etkinliklerList =
        result.map((e) => Etkinlikler.fromMap(e)).toList();
    return etkinliklerList;
  }

  Future<int> updateEtkinlik(Etkinlikler etkinlik) async {
    var dbClient = await theDb;
    if (etkinlik.id == null) {
      print("Id is NULL");
    }
    try {
      return await dbClient.update(
        'Etkinlikler',
        etkinlik.toMap(),
        where: 'id = ?',
        whereArgs: [etkinlik.id],
      );
    } catch (error) {
      print("Güncelleme hatası: $error");
      return 0;
    }
  }

// Silme fonksiyonu
  Future<int> deleteEtkinlik(int id) async {
    var dbClient = await theDb;
    return await dbClient.delete(
      'Etkinlikler',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertFoodList(FoodList foodList) async {
    var dbClient = await theDb;
    return await dbClient.insert('FoodList', foodList.toMap());
  }

  Future<List<FoodList>> loadFoodList(String className) async {
    var dbClient = await theDb;
    var result = await dbClient
        .query('FoodList', where: 'className = ?', whereArgs: [className]);
    List<FoodList> foodList = result.map((e) => FoodList.fromMap(e)).toList();
    return foodList;
  }

  Future<int> updateFoodList(FoodList foodList) async {
    var dbClient = await theDb;
    if (foodList.id == null) {
      print("Id is NULL");
    }
    try {
      return await dbClient.update(
        'FoodList',
        foodList.toMap(),
        where: 'id = ?',
        whereArgs: [foodList.id],
      );
    } catch (error) {
      print("Güncelleme hatası: $error");
      return 0;
    }
  }

// Silme fonksiyonu
  Future<int> deleteFoodList(int id) async {
    var dbClient = await theDb;
    return await dbClient.delete(
      'FoodList',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Students>> getStudentsbyTeacher(String className) async {
    var dbClient = await theDb;
    var result = await dbClient
        .query('Students', where: 'className = ?', whereArgs: [className]);
    List<Students> studentList =
        result.map((e) => Students.fromMap(e)).toList();
    return studentList;
  }

  Future<List<Payment>> getPaymentsbyStudent(String studentId) async {
    var dbClient = await theDb;
    var result = await dbClient
        .query('Payment', where: 'studentId = ?', whereArgs: [studentId]);
    List<Payment> paymentList = result.map((e) => Payment.fromMap(e)).toList();
    return paymentList;
  }

  Future<Students?> getStudentIdbyParent(Parents parent) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient.rawQuery(
        'SELECT S.studentId FROM Parents as P JOIN  Students as S ON P.studentId = S.studentId WHERE P.userId = ?',
        [parent.userId]);

    if (result.length > 0) {
      return Students.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<int> insertendofDayStudent(EndofDay endofDay) async {
    var dbClient = await theDb;
    return await dbClient.insert('EndofDay', endofDay.toMap());
  }

  Future<List<EndofDay>> loadendofDayStudents(String className) async {
    var dbClient = await theDb;
    var result = await dbClient
        .query('EndofDay', where: 'className = ?', whereArgs: [className]);
    List<EndofDay> endofDay = result.map((e) => EndofDay.fromMap(e)).toList();
    return endofDay;
  }

  Future<int> updateEndofDayStudent(EndofDay endofDay) async {
    var dbClient = await theDb;
    if (endofDay.studentId == "null") {
      print("Id is NULL");
    }
    try {
      return await dbClient.update(
        'EndofDay',
        endofDay.toMap(),
        where: 'studentId = ?',
        whereArgs: [endofDay.studentId],
      );
    } catch (error) {
      print("Güncelleme hatasi: $error");
      return 0;
    }
  }

// Silme fonksiyonu
  Future<int> deleteEndofDayStudent(String studentId) async {
    var dbClient = await theDb;
    return await dbClient.delete(
      'endofDay',
      where: 'studentId = ?',
      whereArgs: [studentId],
    );
  }

  Future<Students?> getStudent(String studentId) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient
        .rawQuery('SELECT * FROM Students WHERE studentId = ?', [studentId]);

    if (result.isNotEmpty) {
      return Students.fromMap(result.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<EndofDay?> getEndofDay(String studentId) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient
        .rawQuery('SELECT * FROM EndofDay WHERE studentId = ?', [studentId]);

    if (result.isNotEmpty) {
      return EndofDay.fromMap(result.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<Chatting>> getMessagesByUser(
      String senderId, String receiverId) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient.rawQuery(
        'SELECT * FROM Chatting WHERE (senderId = ? AND receiverId= ?) OR (receiverId = ? AND senderId= ?)  ORDER BY id ASC',
        [senderId, receiverId, senderId, receiverId]);
    if (result.isNotEmpty) {
      return result
          .map((map) => Chatting.fromMap(map as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<int> insertMessages(Chatting chatting) async {
    var dbClient = await theDb;
    return await dbClient.insert('Chatting', chatting.toMap());
  }

  Future<List<Parents>> getParentsbyTeachers(Teachers teacher) async {
    var dbClient = await theDb;
    List<Map> results = await dbClient.rawQuery(
        'SELECT Parents.* FROM Teachers JOIN Students ON Teachers.className = Students.className JOIN Parents ON Students.studentId = Parents.studentId WHERE Teachers.userId =?',
        [teacher.userId]);

    List<Parents> parentsList = results
        .map((map) => Parents.fromMap(map as Map<String, dynamic>))
        .toList();

    return parentsList;
  }

  Future<Teachers?> getTeacherByParent(Parents parent) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient.rawQuery(
        'SELECT T.* FROM Parents as P JOIN Students as S ON P.studentId = S.studentId JOIN Teachers as T ON S.className = T.className WHERE P.userId = ?',
        [parent.userId]);

    if (result.length > 0) {
      return Teachers.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }

  Future<Students?> getStudentsbyParent(Parents parent) async {
    var dbClient = await theDb;
    List<Map> result = await dbClient.rawQuery(
        'SELECT S.* FROM Parents as P JOIN  Students as S ON P.studentId = S.studentId WHERE P.userId = ?',
        [parent.userId]);

    if (result.length > 0) {
      return Students.fromMap(result.first as Map<String, dynamic>);
    }

    return null;
  }
}
