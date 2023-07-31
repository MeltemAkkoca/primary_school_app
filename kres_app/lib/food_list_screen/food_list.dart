import 'package:flutter/material.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:intl/intl.dart';
import '../models/food_list.dart';

class FoodListScreen extends StatelessWidget {
  final String studentClassName;

  const FoodListScreen({Key? key, required this.studentClassName})
      : super(key: key);

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
          backgroundColor: Color.fromARGB(255, 85, 120, 106),
        ),
        body: FutureBuilder<List<FoodList>>(
          future: DatabaseHelper().loadFoodList(studentClassName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<FoodList> foodList = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 246, 246, 246),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ListView.builder(
                          itemCount: foodList.length,
                          itemBuilder: (context, index) {
                            String dateStr = foodList[index].tarih;
                            if (!isValidDate(dateStr)) {
                              return Text(
                                  'Tarih uygun formatta değil: $dateStr. Lütfen uygun bir formata dönüştürün.');
                            }
                            DateTime date =
                                DateFormat('dd.MM.yyyy').parse(dateStr);
                            String monthName = DateFormat('MMMM').format(date);
                            String dayName = DateFormat('EEEE').format(date);
                            String dayNumber = DateFormat('dd').format(date);

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Divider(thickness: 1.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(children: [
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
                                      ]),
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
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
