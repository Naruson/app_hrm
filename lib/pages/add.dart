import 'package:app_hrm/pages/department.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget {
  //const AddPage({ Key? key }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Female';

  // List of items in our dropdown menu
  //https://www.geeksforgeeks.org/flutter-dropdownbutton-widget/
  var gender = [
    'Female',
    'Male',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddPage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: 'Title',
              ),
            ),
            mySizedBoxSmall(),
            TextFormField(
              minLines: 4,
              maxLines: null,
              keyboardType: TextInputType.text,
              controller: detail,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: 'Detail',
              ),
            ),

            //dropdown
            mySizedBoxSmall(),
            ElevatedButton(
                onPressed: () {
                  print('title: ${title.text}');
                  print('detail: ${detail.text}');
                  postTodo();
                  setState(() {
                    title.clear();
                    detail.clear();
                  });
                  Navigator.pop(context, 'add');
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ListData()));
                },
                child: Text("Submit")),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    //http://10.80.74.246:8080/api/v3/user
    // var url = Uri.http('10.80.25.48:8000', '/api/v3/user');
    var url = Uri.http('127.0.0.1:8000', '/api/post-todolist');
    //ประเภทของ Data ที่เราจะส่งไป เป็นแบบ json
    Map<String, String> header = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      "Accept": "*/*"
    };
    //Data ที่จะส่ง
    String jsondata = '{"title":"${title.text}", "detail":"${detail.text}"}';
    // String jsondata = '{"title":"AAA", "detail":"BBB"}';
    // String jsondata = '{"title":"test", "detail": "test"}';

    //เป็นการ Response ค่าแบบ POST
    var response = await http.post(url, headers: header, body: jsondata);
    print('------result-------');
    print(response.body);
  }
}

Widget mySizedBoxSmall() {
  return SizedBox(
    height: 20,
  );
}
