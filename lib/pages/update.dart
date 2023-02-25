import 'package:crudproject/pages/listdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';

class UpdatePage extends StatefulWidget {
  // const UpdatePage({ Key? key }) : super(key: key);

  final v1, v2, v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Female';
  var _v1, _v2, _v3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    title.text = _v2;
    detail.text = _v3;
  }

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
        title: Text("Update Page"),
        actions: [
          IconButton(
            onPressed: () {
              print("Delete ID: $_v1");
              deleteTodo().then((value) {
                Navigator.pop(context, 'delete');
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
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
                  updateTodo();
                  final snackBar = SnackBar(
                      content: const Text('อัพเดตรายการเรียบร้อยแล้ว'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context, 'update');
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ListData()));
                },
                child: Text("Update")),
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    //
    var url = Uri.http('127.0.0.1:8000', '/api/update-todolist/$_v1');
    //ประเภทของ Data ที่เราจะส่งไป เป็นแบบ json
    Map<String, String> header = {"Content-type": "application/json"};
    //Data ที่จะส่ง
    String jsondata = '{"title":"${title.text}", "detail":"${detail.text}"}';

    //เป็นการ Response ค่าแบบ POST
    var response = await http.put(url, headers: header, body: jsondata);
    print('------result-------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('127.0.0.1:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('------result-------');
    print(response.body);
  }
}

Widget mySizedBoxSmall() {
  return SizedBox(
    height: 20,
  );
}
