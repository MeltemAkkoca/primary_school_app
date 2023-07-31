import 'package:flutter/material.dart';
//import '../../food_list_screen/data/food_list_data.dart';
import '../../models/food_list.dart';
import '../../models/user_authentication/database_helper.dart';
import '../../models/user_authentication/teachers.dart';
import 'package:intl/intl.dart';

class NewFoodListScreen extends StatefulWidget {
  final Teachers teacher;
  final FoodList? foodList;

  NewFoodListScreen({required this.teacher, this.foodList});

  @override
  _NewFoodListScreenState createState() => _NewFoodListScreenState();
}

class _NewFoodListScreenState extends State<NewFoodListScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tarihController;
  late TextEditingController saatController;
  late TextEditingController food1Controller;
  late TextEditingController food2Controller;
  late TextEditingController food3Controller;
  late TextEditingController food4Controller;

  @override
  void initState() {
    super.initState();
    FoodList? foodList = widget.foodList;

    tarihController = TextEditingController(text: foodList?.tarih ?? '');
    saatController = TextEditingController(text: foodList?.saat ?? '');
    food1Controller = TextEditingController(text: foodList?.food1 ?? '');
    food2Controller = TextEditingController(text: foodList?.food2 ?? '');
    food3Controller = TextEditingController(text: foodList?.food3 ?? '');
    food4Controller = TextEditingController(text: foodList?.food4 ?? '');
  }

  @override
  void dispose() {
    tarihController.dispose();
    saatController.dispose();
    food1Controller.dispose();
    food2Controller.dispose();
    food3Controller.dispose();
    food4Controller.dispose();
    super.dispose();
  }

  _saveFoodList() async {
    if (_formKey.currentState!.validate()) {
      FoodList foodList = FoodList(
        id: widget.foodList?.id,
        className: widget.teacher.className,
        tarih: tarihController.text,
        saat: saatController.text,
        food1: food1Controller.text,
        food2: food2Controller.text,
        food3: food3Controller.text,
        food4: food4Controller.text,
      );

      if (widget.foodList != null) {
        // FoodList güncelleme
        int result = await DatabaseHelper().updateFoodList(foodList);
        if (result != 0) {
          // Güncelleme başarılı
          DatabaseHelper()
              .loadFoodList(widget.teacher.className); // Verileri yeniden yükle
        } else {
          // Güncelleme başarısız
          print("Güncelleme işlemi başarısız.");
        }
      } else {
        // Yeni food list ekleme
        DatabaseHelper().insertFoodList(foodList);
      }

      Navigator.pop(context); // Food List sayfasına dön
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        tarihController.text = DateFormat('dd.MM.yyyy').format(picked);
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        saatController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodList != null
            ? 'Yemek Listesini Düzenle'
            : 'Yeni Yemek Listesi Ekle'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tarihController,
                decoration: InputDecoration(
                  labelText: 'Tarih',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: saatController,
                decoration: InputDecoration(
                  labelText: 'Saat',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: food1Controller,
                decoration: InputDecoration(labelText: 'Food 1:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: food2Controller,
                decoration: InputDecoration(labelText: 'Food 2: '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: food3Controller,
                decoration: InputDecoration(labelText: 'Food 3:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: food4Controller,
                decoration: InputDecoration(labelText: 'Food 4:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _saveFoodList,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
