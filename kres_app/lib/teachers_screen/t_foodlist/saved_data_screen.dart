import 'package:flutter/material.dart';
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
        int result = await DatabaseHelper().updateFoodList(foodList);
        if (result != 0) {
          DatabaseHelper()
              .loadFoodList(widget.teacher.className); // Verileri yeniden yükle
        } else {
          print("Güncelleme işlemi başarısız.");
        }
      } else {
        DatabaseHelper().insertFoodList(foodList);
      }

      Navigator.pop(context);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: onTap != null
              ? IconButton(
                  icon: Icon(label == 'Tarih'
                      ? Icons.calendar_today
                      : Icons.access_time),
                  onPressed: onTap)
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bu alan boş bırakılamaz';
          }
          return null;
        },
      ),
    );
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
    return Theme(
      data: ThemeData(
        primaryColor: Color.fromARGB(255, 43, 117, 88),
        hintColor: Color.fromARGB(255, 43, 117, 88),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          primary: Color.fromARGB(255, 43, 117, 88),
          secondary: Color.fromARGB(255, 43, 117, 88),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 43, 117, 88),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 43, 117, 88),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 43, 117, 88),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 43, 117, 88),
        ),
      ),
      child: Scaffold(
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
                _buildTextField(tarihController, 'Tarih',
                    onTap: () => _selectDate(context)),
                _buildTextField(saatController, 'Saat',
                    onTap: () => _selectTime(context)),
                _buildTextField(food1Controller, 'Yemek 1'),
                _buildTextField(food2Controller, 'Yemek 2'),
                _buildTextField(food3Controller, 'Yemek 3'),
                _buildTextField(food4Controller, 'Yemek 4'),
                ElevatedButton(
                  onPressed: _saveFoodList,
                  child: Text('Kaydet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
