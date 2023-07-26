import 'package:flutter/material.dart';
import '../../endofday_screen/data/endofday_data.dart';

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
                  hintText: 'Enter value', // Placeholder text in the text field
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Your other classes and data remain unchanged

// Additional page to show the saved data
class ShowDataPage extends StatelessWidget {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String lastDate;
  final String status;

  ShowDataPage({
    required this.subjectName,
    required this.topicName,
    required this.assignDate,
    required this.lastDate,
    required this.status,
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
            Text('Subject Name: $subjectName'),
            Text('Topic Name: $topicName'),
            Text('Assign Date: $assignDate'),
            Text('Last Date: $lastDate'),
            Text('Status: $status'),
          ],
        ),
      ),
    );
  }
}

class TeacherEndOfDay extends StatefulWidget {
  const TeacherEndOfDay({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

  @override
  _EndOfDayState createState() => _EndOfDayState();
}

class _EndOfDayState extends State<TeacherEndOfDay> {
  String subjectName = '';
  String topicName = '';
  String assignDate = '';
  String lastDate = '';
  String status = '';

  final _formKey = GlobalKey<FormState>();

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, save the data here or navigate to another page.
      // For example:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDataPage(
            subjectName: subjectName,
            topicName: topicName,
            assignDate: assignDate,
            lastDate: lastDate,
            status: status,
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Kahvaltı:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          subjectName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter subject name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Öğle Yemeği:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          subjectName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter subject name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Uyku:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          subjectName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter subject name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Repeat the above pattern for other fields like 'topicName', 'assignDate', etc.
              // ...
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 10, 89, 37), // Change the color to blue
                    ),
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// // Your other imports and classes remain unchanged

// // Additional page to show the saved data
// class ShowDataPage extends StatelessWidget {
//   // Remaining code for ShowDataPage class remains unchanged
// }

// class TeacherEndOfDay extends StatefulWidget {
//   const TeacherEndOfDay({Key? key}) : super(key: key);
//   static String routeName = 'AssignmentScreen';

//   @override
//   _EndOfDayState createState() => _EndOfDayState();
// }

// class _EndOfDayState extends State<TeacherEndOfDay> {
//   String subjectName = '';
//   String topicName = '';
//   String assignDate = '';
//   String lastDate = '';
//   String status = '';

//   final _formKey = GlobalKey<FormState>();

//   Widget getStatusIcon(String status) {
//     switch (status) {
//       case 'iyi':
//         return Image.asset('assets/good.png'); // Replace 'good.png' with the actual asset path
//       case 'kötü':
//         return Image.asset('assets/bad.png'); // Replace 'bad.png' with the actual asset path
//       case 'orta':
//         return Image.asset('assets/neutral.png'); // Replace 'neutral.png' with the actual asset path
//       default:
//         return SizedBox.shrink();
//     }
//   }

//   void _saveData() {
//     if (_formKey.currentState!.validate()) {
//       // Form is valid, save the data here or navigate to another page.
//       // For example:
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ShowDataPage(
//             subjectName: subjectName,
//             topicName: topicName,
//             assignDate: assignDate,
//             lastDate: lastDate,
//             status: status,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gün Sonu'),
//         backgroundColor: Color.fromARGB(255, 43, 117, 88),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Kahvaltı:',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           subjectName = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter subject name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     getStatusIcon(status), // Add the status icon here
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Öğle Yemeği:',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           topicName = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter topic name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     getStatusIcon(status), // Add the status icon here
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Uyku:',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           assignDate = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter assign date';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     getStatusIcon(status), // Add the status icon here
//                   ],
//                 ),
//               ),

//               // Repeat the above pattern for other fields like 'topicName', 'assignDate', etc.
//               // ...

//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: _saveData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(
//                           255, 10, 89, 37), // Change the color to blue
//                     ),
//                     child: Text('Save'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


