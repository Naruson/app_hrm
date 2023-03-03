import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List to hold the TextField widgets
  List<Widget> _textFields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Text Field on Button Click'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: _textFields,
            ),
            ElevatedButton(
              onPressed: () {
                // Add a new TextField widget to the list
                setState(() {
                  int index = _textFields.length;
                  _textFields.add(
                    TextField(
                      key: Key(
                          '$index'), // Assign a unique key to the TextField widget
                      decoration: InputDecoration(
                        hintText: 'Enter some text',
                      ),
                    ),
                  );
                });
              },
              child: Text('Add Text Field'),
            ),
            ElevatedButton(
              onPressed: () {
                // Remove the last TextField widget from the list
                setState(() {
                  if (_textFields.isNotEmpty) {
                    _textFields.removeLast();
                  }
                });
              },
              child: Text('Delete Text Field'),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textFieldController = TextEditingController();

//   Widget _textFieldWidget() {
//     return TextField(
//       controller: _textFieldController,
//       decoration: InputDecoration(
//         hintText: 'Enter some text',
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Text Field on Button Click'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text('Enter Text'),
//                       content: _textFieldWidget(),
//                       actions: <Widget>[
//                         TextButton(
//                           child: Text('CANCEL'),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         TextButton(
//                           child: Text('SAVE'),
//                           onPressed: () {
//                             Navigator.pop(context);
//                             // Do something with the text entered by the user
//                             String enteredText = _textFieldController.text;
//                             print('Entered Text: $enteredText');
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text('Create Text Field'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }