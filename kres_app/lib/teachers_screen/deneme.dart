import 'package:flutter/material.dart';
import 'package:meditation_app/login_screen/login_screen.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/teachers_screen/chatting.dart/chat_home.dart';
import 'package:meditation_app/teachers_screen/t_activities/t_activities_screen.dart';
import 'package:meditation_app/teachers_screen/t_foodlist/t_foodlist_screen.dart';
import 'package:meditation_app/teachers_screen/t_endofday/t_endofday_screen.dart';

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
      appBar: AppBar(
        title: Center(
          child: Text('Merhaba ${widget.teacher.userName}!',
              style: TextStyle(fontSize: 18)),
        ),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 230, 235, 233),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuItem('assets/notification.png', 'MESAJLAŞMA', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatHomePageScreen(
                            teacher: widget.teacher,
                          ),
                        ),
                      );
                    }),
                    _buildMenuItem('assets/activities.png', 'ETKİNLİKLER', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherAssignmentScreen(
                            teacher: widget.teacher,
                          ),
                        ),
                      );
                    }),
                    _buildMenuItem('assets/endofday.png', 'GÜN SONU', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherEndofDayScreen(
                            teacher: widget.teacher,
                          ),
                        ),
                      );
                    }),
                    _buildMenuItem('assets/messages.png', 'YEMEK LİSTESİ', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherFoodListScreen(
                            teacher: widget.teacher,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String imagePath, String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2, // genişlik değiştirildi
        height:
            MediaQuery.of(context).size.height / 8, // yükseklik değiştirildi
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 171, 189, 176),
          borderRadius: BorderRadius.circular(20),
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
