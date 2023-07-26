import 'package:flutter/material.dart';
import 'package:meditation_app/food_list_screen/data/food_list_data.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({Key? key}) : super(key: key);

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
                            topRight: Radius.circular(20))),
                    child: ListView.builder(
                        itemCount: foodlist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 8,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Divider(thickness: 1.0),
                                ),
                                //first need a row,then 3 columns
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //first column
                                    Column(children: [
                                      Text(
                                        foodlist[index].date.toString(),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        foodlist[index].monthName,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        foodlist[index].dayName,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                                    //second column
                                    Column(
                                      children: [
                                        Text(
                                          foodlist[index].food1,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                        Text(
                                          foodlist[index].food2,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                        Text(
                                          foodlist[index].food3,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                        Text(
                                          foodlist[index].food4,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    //3. column
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Saat ikonunu içeren Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.access_time,
                                                color: Colors.black87,
                                                size: 16.0),
                                            SizedBox(
                                                width:
                                                    5), // İkon ile metin arasında boşluk için
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
                        })))
          ],
        ));
  }
}
