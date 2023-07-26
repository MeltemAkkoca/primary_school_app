import 'package:flutter/material.dart';
import 'package:meditation_app/food_list_screen/data/food_list_data.dart';
import 'package:meditation_app/teachers_screen/t_foodlist/saved_data_screen.dart';

class TeacherFoodListScreen extends StatelessWidget {
  const TeacherFoodListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Listesi'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 246, 246, 246),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                itemCount: foodlist.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(thickness: 1.0),
                        //first need a row,then 3 columns
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //first column
                            Column(
                              children: [
                                Text(
                                  foodlist[index].date.toString(),
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Adding spacing between date and monthName
                                Text(
                                  foodlist[index].monthName,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Adding spacing between monthName and dayName
                                Text(
                                  foodlist[index].dayName,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                width:
                                    20), // Adding spacing between the columns
                            //second column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Food 1',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Food 2',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Food 3',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Food 4',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width:
                                    20), // Adding spacing between the columns
                            //3. column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Saat ikonunu içeren Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.black87,
                                      size: 16.0,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      foodlist[index].time,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ],
                                ),
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _navigateToSavedDataScreen(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 10, 89, 37), // Change the color to blue
              ),
              child: Text('Kaydet'),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSavedDataScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedDataScreen(
          foodList: foodlist,
        ),
      ),
    );
  }
}
