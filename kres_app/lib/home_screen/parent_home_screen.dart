import 'package:flutter/material.dart';
import 'package:meditation_app/endofday_screen/endofday_screen.dart';
import 'package:meditation_app/message_screen/message_form_screen.dart';
import 'package:meditation_app/models/students.dart';
import '../activities_screen/activities_screen.dart';
import '../fee_screen/fee_screen.dart';
import '../food_list_screen/food_list.dart';
import '../models/user_authentication/parents.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';

class ParentHomeScreen extends StatefulWidget {
  final Parents parent;

  ParentHomeScreen({Key? key, required this.parent}) : super(key: key);

  @override
  _ParentHomeScreen createState() => _ParentHomeScreen();
}

class _ParentHomeScreen extends State<ParentHomeScreen> {
  String? studentClassName;
  String? studentId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var dbHelper = DatabaseHelper();
    Students? fetchedStudentClass =
        await dbHelper.getStudentClassNamebyParent(widget.parent);
    Students? fetchedStudentId =
        await dbHelper.getStudentIdbyParent(widget.parent);

    if (fetchedStudentClass != null) {
      setState(() {
        studentClassName = fetchedStudentClass.className;
      });
    }
    if (fetchedStudentId != null) {
      setState(() {
        studentId = fetchedStudentId.studentId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      //ekranı ikiye bölüyorum
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.8,
          color: Color.fromARGB(255, 43, 117, 88),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Merhaba',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 244, 245, 244)),
                          ),
                          Text(
                            ' ${widget.parent.userName}!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 244, 245, 244)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 230, 235, 233),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            studentClassName ?? 'Gelmedi',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 89, 37)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20 / 6,
                  ),
                  // GestureDetector(
                  //   child: CircleAvatar(
                  //     minRadius: 50.0,
                  //     maxRadius: 50.0,
                  //     backgroundColor: Color.fromARGB(255, 246, 247, 245),
                  //     backgroundImage: AssetImage('assets/girl_avatar.png'),
                  //   ),
                  // )
                ],
              ),
            ],
          )),
      Expanded(
          child: Container(
              color: Color.fromARGB(255, 43, 117, 88),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 230, 235, 233),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        //bosluk
                        SizedBox(height: 50),
                        //mesaj bırakma kısmı
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FormPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 12,
                                padding: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 171, 189, 176),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 171, 189, 176),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/notification.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 50.0),
                                      Text(
                                        'MESAJLAŞMA',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 10, 89, 37)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //bosluk

                        SizedBox(height: 50),
                        //aktiviteler kutusu
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AssignmentScreen(
                                      studentClassName: studentClassName ??
                                          'DefaultClassName',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 12,
                                padding: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 117, 88),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 171, 189, 176),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/activities.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 50.0),
                                      Text(
                                        'ETKİNLİKLER',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 10, 89, 37)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        //gün sonu
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EndOfDay(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 12,
                                padding: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 117, 88),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 171, 189, 176),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/endofday.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 50.0),
                                      Text(
                                        'GÜN SONU',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 10, 89, 37)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //yemek listesi
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodListScreen(
                                      studentClassName: studentClassName ??
                                          'DefaultClassName',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 12,
                                padding: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 117, 88),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 171, 189, 176),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/messages.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 50.0),
                                      Text(
                                        'YEMEK LİSTESİ',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 10, 89, 37)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width / 1.1,
                            //   height: MediaQuery.of(context).size.height / 12,
                            //   padding: EdgeInsets.symmetric(),
                            //   decoration: BoxDecoration(
                            //     color: Color.fromARGB(255, 43, 117, 88),
                            //     borderRadius: BorderRadius.circular(20),
                            //   ),
                            //   child: GestureDetector(
                            //     child: Container(
                            //       width: 100.0,
                            //       height: 100.0,
                            //       decoration: BoxDecoration(
                            //         // sshape: BoxShape.circle,
                            //         borderRadius: BorderRadius.circular(20),
                            //         color: Color.fromARGB(255, 171, 189, 176),
                            //       ),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           ClipOval(
                            //             child: Image.asset(
                            //               'assets/messages.png',
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //           SizedBox(width: 50.0),
                            //           Text(
                            //             'YEMEK LİSTESİ',
                            //             style: TextStyle(
                            //                 fontSize: 28.0,
                            //                 fontWeight: FontWeight.w400,
                            //                 color: Color.fromARGB(
                            //                     255, 10, 89, 37)),
                            //             textAlign: TextAlign.center,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeeScreen(
                                      studentId:
                                          studentId ?? 'DefaultStudentId',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 12,
                                padding: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 117, 88),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 171, 189, 176),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/payfee.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 50.0),
                                      Text(
                                        'ÖDEMELER',
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 10, 89, 37)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )))
    ]));
  }
}
