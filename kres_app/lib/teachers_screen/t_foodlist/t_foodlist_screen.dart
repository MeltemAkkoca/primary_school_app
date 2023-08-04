import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/models/food_list.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/teachers_screen/t_foodlist/saved_data_screen.dart';

class TeacherFoodListScreen extends StatefulWidget {
  final Teachers teacher;

  const TeacherFoodListScreen({Key? key, required this.teacher})
      : super(key: key);

  @override
  _TeacherFoodListScreenState createState() => _TeacherFoodListScreenState();
}

class _TeacherFoodListScreenState extends State<TeacherFoodListScreen> {
  List<FoodList> foodList = [];

  @override
  void initState() {
    super.initState();
    _loadFoodList();
  }

  Future<void> _loadFoodList() async {
    foodList = await DatabaseHelper().loadFoodList(widget.teacher.className);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Listesi'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewFoodListScreen(teacher: widget.teacher),
            ),
          ).then((value) => _loadFoodList());
        },
        tooltip: 'Yeni Yemek Listesi Ekle',
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: foodList.isEmpty
          ? Center(
              child: Text(
                'Yemek listesi yok, lütfen bir yemek listesi ekleyin.',
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<FoodList>>(
                future: DatabaseHelper().loadFoodList(widget.teacher.className),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    foodList = snapshot.data!;
                    return ListView.builder(
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        DateTime date = DateFormat('dd.MM.yyyy')
                            .parse(foodList[index].tarih);
                        String monthName = DateFormat('MMMM').format(date);
                        String dayName = DateFormat('EEEE').format(date);
                        String dayNumber = DateFormat('dd').format(date);

                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          width: MediaQuery.of(context).size.width - 16.0,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        dayNumber,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        monthName,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        dayName,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        foodList[index].food1,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        foodList[index].food2,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        foodList[index].food3,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        foodList[index].food4,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.access_time,
                                              color: Colors.black87,
                                              size: 16.0),
                                          SizedBox(width: 5),
                                          Text(
                                            foodList[index].saat,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NewFoodListScreen(
                                            foodList: foodList[index],
                                            teacher: widget.teacher,
                                          ),
                                        ),
                                      ).then((value) => _loadFoodList());
                                    },
                                    icon:
                                        Icon(Icons.edit, color: Colors.black87),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await DatabaseHelper()
                                          .deleteFoodList(foodList[index].id!);
                                      _loadFoodList();
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
    );
  }
}
