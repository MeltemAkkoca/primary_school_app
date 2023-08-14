import 'package:flutter/material.dart';
//import 'package:meditation_app/food_list_screen/data/food_list_data.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:intl/intl.dart';
import '../models/food_list.dart';

class FoodListScreen extends StatelessWidget {
  final String studentClassName;

  FoodListScreen({Key? key, required this.studentClassName}) : super(key: key);

  static String routeName = 'FoodListScreen';

  bool isValidDate(String input) {
    try {
      DateFormat('dd.MM.yyyy').parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Listesi'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: FutureBuilder<List<FoodList>>(
        future: DatabaseHelper().loadFoodList(studentClassName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<FoodList> foodList = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        String dateStr = foodList[index].tarih;
                        if (!isValidDate(dateStr)) {
                          return Center(
                            child: Text(
                              'Tarih uygun formatta değil: $dateStr. Lütfen uygun bir formata dönüştürün.',
                            ),
                          );
                        }
                        DateTime date = DateFormat('dd.MM.yyyy').parse(dateStr);
                        String monthName = DateFormat('MMMM').format(date);
                        String dayName = DateFormat('EEEE').format(date);
                        String dayNumber = DateFormat('dd').format(date);

                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          width: MediaQuery.of(context).size.width - 16.0,
                          height: MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(dayNumber,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold)),
                                  Text(monthName,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500)),
                                  Text(dayName,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.access_time,
                                          color: Colors.black87, size: 16.0),
                                      SizedBox(width: 5),
                                      Text(foodList[index].saat,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.0,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
