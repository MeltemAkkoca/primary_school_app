import 'package:flutter/material.dart';
import 'package:meditation_app/home_screen/home_screen.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/models/user_authentication/users.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';

import '../home_screen/parent_home_screen.dart';
import '../models/user_authentication/parents.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Image.asset(
                "assets/logo.png",
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(100, 150, 150, 150),
                        blurRadius: 10,
                        blurStyle: BlurStyle.solid,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(100, 150, 150, 150),
                        blurRadius: 10,
                        blurStyle: BlurStyle.solid,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MaterialButton(
                color: Color.fromARGB(255, 43, 117, 88),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  DatabaseHelper dbHelper = DatabaseHelper();
                  User? user = await dbHelper.getUser(username, password);

                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Username or password incorrect')));
                    return;
                  }
                  if (user.userRole == 'teacher') {
                    Teachers? teacher = await dbHelper.getTeacher(user);
                    if (teacher != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(teacher: teacher),
                        ),
                      );
                    }
                  } else if (user.userRole == 'parent') {
                    Parents? parent = await dbHelper.getParent(user);
                    if (parent != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ParentHomeScreen(parent: parent),
                        ),
                      );
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don’t have an account, ",
                    style: TextStyle(
                      color: Color(0xFF969696),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Sign Up ",
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "now.",
                    style: TextStyle(
                      color: Color(0xFF969696),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              const Text(
                "Or",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/google.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/apple.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/fb.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
