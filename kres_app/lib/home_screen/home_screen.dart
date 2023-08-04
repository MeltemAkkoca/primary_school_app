import 'package:flutter/material.dart';
import 'package:meditation_app/login_screen/login_screen.dart';
import 'package:meditation_app/message_screen/message_form_screen.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/teachers_screen/chatting.dart/chat_home.dart';
import 'package:meditation_app/teachers_screen/t_activities/t_activities_screen.dart';
import 'package:meditation_app/teachers_screen/t_foodlist/t_foodlist_screen.dart';
import '../teachers_screen/t_endofday/t_endofday_screen.dart';

class HomeScreen extends StatefulWidget {
  final Teachers teacher;

  HomeScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
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
                            ' ${widget.teacher.userName}!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 244, 245, 244)),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              color: Color.fromARGB(255, 244, 245, 244),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
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
                            '${widget.teacher.className}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 89, 37)),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatHomePageScreen(
                                  teacher: widget.teacher,
                                ),
                              ),
                            );
                          },
                          child: _buildContainer(
                              'assets/notification.png', 'MESAJLAŞMA'),
                        ),
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
                                builder: (context) => TeacherAssignmentScreen(
                                    teacher: widget.teacher),
                              ),
                            );
                          },
                          child: _buildContainer(
                              'assets/activities.png', 'ETKİNLİKLER'),
                        ),
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
                                builder: (context) => TeacherEndofDayScreen(
                                  teacher: widget.teacher,
                                ),
                              ),
                            );
                          },
                          child: _buildContainer(
                              'assets/endofday.png', 'GÜN SONU'),
                        ),
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
                                builder: (context) => TeacherFoodListScreen(
                                    teacher: widget.teacher),
                              ),
                            );
                          },
                          child: _buildContainer(
                              'assets/messages.png', 'YEMEK LİSTESİ'),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ]));
  }

  Container _buildContainer(String imagePath, String title) {
    return Container(
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
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 50.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 10, 89, 37)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
