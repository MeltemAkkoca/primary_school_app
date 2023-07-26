import 'package:flutter/material.dart';
import 'sendedform_screen.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
        title: Text('Mesajlaşma'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'İsminizi Giriniz',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telefon numaranızı giriniz',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Not bırakınız',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SendedForm(
                    name: _name.text,
                    email: _email.text,
                    phone: _phone.text,
                  ),
                ),
              );
            },
            child: Text('Gönder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 10, 89,
                  37), // Gönder butonunun rengini yeşil olarak ayarlar
            ),
          ),
        ],
      ),
    );
  }
}
// class FormPage extends StatefulWidget {
//   const FormPage({Key? key}) : super(key: key);

//   @override
//   _FormPageState createState() => _FormPageState();
// }

// class _FormPageState extends State<FormPage> {
//   TextEditingController _name = TextEditingController();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _phone = TextEditingController();

//   @override
//   void dispose() {
//     _name.dispose();
//     _email.dispose();
//     _phone.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 43, 117, 88),
//         automaticallyImplyLeading: false, // Geri tuşunu gizler
//         title: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(
//                 'assets/images/logo.png', // Eklemek istediğiniz resmin yolunu belirtin
//                 height: 32,
//                 width: 32,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text(
//                 'Mesajlaşma',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//     constraints: BoxConstraints(
//       minHeight: MediaQuery.of(context).size.height,
//     ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _name,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'İsminizi Giriniz',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _email,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Telefon numaranızı giriniz',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _phone,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Not bırakınız',
//                 ),
//                 maxLines: null,
//                 keyboardType: TextInputType.multiline,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => SendedForm(
//                       name: _name.text,
//                       email: _email.text,
//                       phone: _phone.text,
//                     ),
//                   ),
//                 );
//               },
//               child: Text('Gönder'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
