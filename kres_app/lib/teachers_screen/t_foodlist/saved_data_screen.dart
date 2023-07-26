import 'package:flutter/material.dart';
import '../../food_list_screen/data/food_list_data.dart';

class SavedDataScreen extends StatelessWidget {
  final List<FoodListData> foodList; // Change Food to FoodListData

  SavedDataScreen({required this.foodList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaydedilen Veriler'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Date: ${foodList[index].date}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Food 1: ${foodList[index].food1}'),
                Text('Food 2: ${foodList[index].food2}'),
                Text('Food 3: ${foodList[index].food3}'),
                Text('Food 4: ${foodList[index].food4}'),
                Text('Time: ${foodList[index].time}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
