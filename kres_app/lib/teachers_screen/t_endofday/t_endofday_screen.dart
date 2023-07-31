import 'package:flutter/material.dart';
import 'package:meditation_app/models/students.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';

class AssignmentDetailRow extends StatelessWidget {
  const AssignmentDetailRow({
    Key? key,
    required this.title,
    required this.statusValueController,
    this.statusIcon,
    this.imageAsset,
  }) : super(key: key);

  final String title;
  final TextEditingController statusValueController;
  final Widget? statusIcon;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Color(0xFF313131),
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
        ),
        Row(
          children: [
            if (statusIcon != null) statusIcon!,
            if (statusIcon != null || imageAsset != null) SizedBox(width: 8),
            if (imageAsset != null) Image.asset(imageAsset!),
            if (imageAsset != null && statusIcon != null) SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: statusValueController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter value',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShowDataPage extends StatelessWidget {
  final String breakfast;
  final String launch;
  final String sleep;
  final String? selectedStudent;

  ShowDataPage({
    required this.breakfast,
    required this.launch,
    required this.sleep,
    this.selectedStudent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Student: ${selectedStudent ?? 'N/A'}'),
            Text('Kahvaltı: $breakfast'),
            Text('Öğlen Yemeği: $launch'),
            Text('Uyku: $sleep'),
          ],
        ),
      ),
    );
  }
}

class TeacherEndOfDay extends StatefulWidget {
  final Teachers teacher;

  TeacherEndOfDay({Key? key, required this.teacher}) : super(key: key);

  @override
  _EndOfDayState createState() => _EndOfDayState();
}

class _EndOfDayState extends State<TeacherEndOfDay> {
  List<Students> students = [];
  String breakfast = '';
  String launch = '';
  String sleep = '';
  Students? selectedStudent;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  loadStudents() async {
    String teacherClassName = widget.teacher.className;
    students = await DatabaseHelper().getStudentsbyTeacher(teacherClassName);
    setState(() {});
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDataPage(
            breakfast: breakfast,
            launch: launch,
            sleep: sleep,
            selectedStudent:
                selectedStudent?.studentFirstName, // Assuming name is a String
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gün Sonu'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButton<Students>(
                  hint: Text('Öğrenci seçiniz'),
                  value: selectedStudent,
                  onChanged: (Students? newValue) {
                    setState(() {
                      selectedStudent = newValue;
                    });
                  },
                  items: students
                      .map<DropdownMenuItem<Students>>((Students value) {
                    return DropdownMenuItem<Students>(
                      value: value,
                      child: Text(
                          '${value.studentFirstName} ${value.studentLastName}'),
                    );
                  }).toList(),
                ),
              ),
              createTextField('Kahvaltı:', 'Lütfen doldurunuz',
                  (value) => breakfast = value),
              createTextField('Öğle Yemeği:', 'Lütfen doldurunuz',
                  (value) => launch = value),
              createTextField(
                  'Uyku:', 'Lütfen doldurunuz', (value) => sleep = value),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 10, 89, 37),
                    ),
                    child: Text('Kaydet'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding createTextField(
      String label, String errorText, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return errorText;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
