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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.event != null ? 'Etkinliği Düzenle' : 'Yeni Etkinlik Ekle'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: eventNameController,
                decoration: InputDecoration(labelText: 'Etkinlik Adı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: startTimeController,
                decoration: InputDecoration(labelText: 'Başlangıç Zamanı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: endTimeController,
                decoration: InputDecoration(labelText: 'Bitiş Zamanı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: eventStatusController,
                decoration: InputDecoration(labelText: 'Etkinlik Durumu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _saveEtkinlik,
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
