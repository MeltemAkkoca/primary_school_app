import 'package:flutter/material.dart';
import "package:meditation_app/models/user_authentication/database_helper.dart";
import "package:meditation_app/models/etkinlikler.dart";
import 'package:meditation_app/models/user_authentication/teachers.dart';

class NewEventScreen extends StatefulWidget {
  final Teachers teacher;
  final Etkinlikler? event;

  NewEventScreen({required this.teacher, this.event});

  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController eventNameController;
  late TextEditingController descriptionController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController eventStatusController;

  @override
  void initState() {
    super.initState();
    Etkinlikler? event = widget.event;

    eventNameController = TextEditingController(text: event?.eventName ?? '');
    descriptionController =
        TextEditingController(text: event?.description ?? '');
    startTimeController = TextEditingController(text: event?.startTime ?? '');
    endTimeController = TextEditingController(text: event?.endTime ?? '');
    eventStatusController =
        TextEditingController(text: event?.eventStatus ?? '');
  }

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    eventStatusController.dispose();
    super.dispose();
  }

  _saveEtkinlik() async {
    if (_formKey.currentState!.validate()) {
      Etkinlikler etkinlik = Etkinlikler(
        id: widget.event?.id,
        className: widget.teacher.className,
        eventName: eventNameController.text,
        description: descriptionController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        eventStatus: eventStatusController.text,
      );

      if (widget.event != null) {
        // Etkinlik güncelleme
        int result = await DatabaseHelper().updateEtkinlik(etkinlik);
        if (result != 0) {
          // Güncelleme başarılı
          DatabaseHelper().loadEtkinlikler(
              widget.teacher.className); // Verileri yeniden yükle
        } else {
          // Güncelleme başarısız
          print("Güncelleme işlemi başarısız.");
        }
      } else {
        // Yeni etkinlik ekleme
        DatabaseHelper().insertEtkinlik(etkinlik);
      }

      Navigator.pop(context); // Etkinlikler sayfasına dön
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Color.fromARGB(255, 85, 120, 106),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(secondary: Color.fromARGB(255, 85, 120, 106)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 85, 120, 106),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 85, 120, 106),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 85, 120, 106),
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 85, 120, 106),
          title: Text(widget.event != null
              ? 'Etkinliği Düzenle'
              : 'Yeni Etkinlik Ekle'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(eventNameController, 'Etkinlik Adı'),
                _buildTextField(descriptionController, 'Description'),
                _buildTextField(startTimeController, 'Başlangıç Zamanı'),
                _buildTextField(endTimeController, 'Bitiş Zamanı'),
                _buildTextField(eventStatusController, 'Etkinlik Durumu'),
                ElevatedButton(
                  onPressed: _saveEtkinlik,
                  child: Text('Kaydet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
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
}
