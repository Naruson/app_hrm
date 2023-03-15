import 'package:app_hrm/pages/createEmployee.dart';
import 'package:app_hrm/pages/department.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PositionPage extends StatefulWidget {
  // const UpdatePage({ Key? key }) : super(key: key);

  final v1, v2;
  const PositionPage(this.v1, this.v2);

  @override
  State<PositionPage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<PositionPage> {
  List positions = [];
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Female';
  var _v1;
  var _v2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    getPosition();
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
        backgroundColor:
            Colors.transparent, // set to transparent to see the gradient effect
        elevation: 0, // remove the default shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 46, 53, 121),
                Color.fromARGB(255, 255, 84, 68),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getPosition();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        title: Text("แผนก $_v2"),
      ),
      body: listData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateEmployeePage()))
              .then((value) {
            setState(() {
              if (value == 'add') {
                final snackBar = SnackBar(
                  content: const Text('เพิ่มรายการเรียบร้อยแล้ว'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
            getPosition();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget listData() {
    return ListView.builder(
        itemCount: positions.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            leading: Icon(
              IconData(0xf7c8, fontFamily: 'MaterialIcons'),
              color: Colors.cyan[200],
            ),
            title: Text("${positions[index]['dp_name_en']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    print('delete');
                    deletePosition('${positions[index]['dp_id']}');
                    getPosition();
                    // do something when delete icon is pressed
                  },
                  child: Icon(Icons.delete),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // do something when more_vert icon is pressed
                  },
                  child: Icon(Icons.more_vert),
                ),
              ],
            ),
          ));
        });
  }

  Future getPosition() async {
    //
    var url =
        Uri.parse('${dotenv.env['BASE_URL']}/app/department/$_v1/position');
    //ประเภทของ Data ที่เราจะส่งไป เป็นแบบ json
    var response = await http.get(url);
    final result = utf8.decode(response.bodyBytes);
    //  "[" + response.body + "]";
    // utf8.decode(response.bodyBytes);

    print(result);
    setState(() {
      positions = jsonDecode(result);
    });
  }

  Future deleteTodo() async {
    var url = Uri.parse('${dotenv.env['BASE_URL']}/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('------result-------');
    print(response.body);
  }

  Future deletePosition(dp_id) async {
    var url =
        Uri.parse('${dotenv.env['BASE_URL']}/app/department/position/$dp_id');
    Map<String, String> header = {
      "Content-type": "application/json",
      'ngrok-skip-browser-warning': 'true',
    };
    var response = await http.delete(url, headers: header);
  }
}

Widget mySizedBoxSmall() {
  return SizedBox(
    height: 20,
  );
}
