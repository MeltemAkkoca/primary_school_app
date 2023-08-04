import 'package:flutter/material.dart';
import 'package:meditation_app/models/end_of_day.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/models/students.dart';

class NewEventScreen extends StatefulWidget {
  final Teachers teacher;
  final EndofDay? endOfDay;

  NewEventScreen({required this.teacher, this.endOfDay});

  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Students> students = [];
  Students? selectedStudent;
  String breakfast = 'iyi';
  String lunch = 'iyi';
  String sleep = 'iyi';
  final List<String> mealOptions = ['iyi', 'orta', 'kötü'];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    loadStudents();

    if (widget.endOfDay != null) {
      isEditing = true;
      breakfast = widget.endOfDay!.breakfast;
      lunch = widget.endOfDay!.lunch;
      sleep = widget.endOfDay!.sleep;
    }
  }

  loadStudents() async {
    String teacherClassName = widget.teacher.className;
    students = await DatabaseHelper().getStudentsbyTeacher(teacherClassName);
    setState(() {
      if (widget.endOfDay != null) {
        selectedStudent = students.firstWhere(
            (student) => student.studentId == widget.endOfDay!.studentId);
      }
    });
  }

  _saveEndofDay() async {
    if (_formKey.currentState!.validate() && selectedStudent != null) {
      EndofDay endOfDay = EndofDay(
        className: widget.teacher.className,
        studentId: selectedStudent!.studentId,
        breakfast: breakfast,
        lunch: lunch,
        sleep: sleep,
      );

      if (widget.endOfDay != null) {
        await DatabaseHelper().updateEndofDayStudent(endOfDay);
      } else {
        await DatabaseHelper().insertendofDayStudent(endOfDay);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Color.fromARGB(255, 43, 117, 88),
        hintColor: Color.fromARGB(255, 43, 117, 88),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.endOfDay == null
              ? 'Gün Sonu Değerlendirmesi'
              : 'Gün Sonu Değerlendirmesini Güncelle'),
          backgroundColor: Color.fromARGB(255, 43, 117, 88),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (isEditing && selectedStudent != null)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Öğrenci: ${selectedStudent!.studentFirstName} ${selectedStudent!.studentLastName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 43, 117, 88)),
                    ),
                  ),
                if (!isEditing ||
                    (selectedStudent == null && widget.endOfDay == null))
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropdownButtonFormField<Students>(
                      hint: Text('Öğrenci seçiniz',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 43, 117, 88))),
                      value: selectedStudent,
                      onChanged: (Students? newValue) {
                        setState(() {
                          selectedStudent = newValue;
                        });
                      },
                      items: students.map<DropdownMenuItem<Students>>(
                        (Students value) {
                          return DropdownMenuItem<Students>(
                            value: value,
                            child: Text(
                                '${value.studentFirstName} ${value.studentLastName}'),
                          );
                        },
                      ).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Öğrenci seçimi zorunludur';
                        }
                        return null;
                      },
                    ),
                  ),
                _buildDropdownField('Kahvaltı:', breakfast, (String? newValue) {
                  setState(() {
                    breakfast = newValue!;
                  });
                }),
                _buildDropdownField('Öğle Yemeği:', lunch, (String? newValue) {
                  setState(() {
                    lunch = newValue!;
                  });
                }),
                _buildDropdownField('Uyku:', sleep, (String? newValue) {
                  setState(() {
                    sleep = newValue!;
                  });
                }),
                ElevatedButton(
                  onPressed: _saveEndofDay,
                  child: Text('Kaydet'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 43, 117, 88),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, String value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: Color.fromARGB(255, 43, 117, 88)), // İstenilen renk kodu
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 43, 117, 88), // İstenilen renk kodu
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 43, 117, 88), // İstenilen renk kodu
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 43, 117, 88), // İstenilen renk kodu
            ),
          ),
        ),
        value: value,
        onChanged: onChanged,
        items: mealOptions.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bu alan boş bırakılamaz';
          }
          return null;
        },
      ),
    );
  }
}
