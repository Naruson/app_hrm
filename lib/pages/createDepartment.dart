import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';

class CreateDepartmentPage extends StatefulWidget {
  // const UpdatePage({ Key? key }) : super(key: key);
  @override
  State<CreateDepartmentPage> createState() => _CreateDepartmentPageState();
}

class _CreateDepartmentPageState extends State<CreateDepartmentPage> {
  TextEditingController dept_name_en = TextEditingController();
  TextEditingController dept_name_th = TextEditingController();

  var _v1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        title: Text("เพิ่มตำแหน่ง"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: dept_name_en,
              decoration: const InputDecoration(
                labelText: 'ชื่อแผนกภาษาอังกฤษ',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dept_name_th,
              decoration: const InputDecoration(
                labelText: 'ชื่อแผนกภาษาไทย',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                print('title: ${dept_name_en.text}');
                print('detail: ${dept_name_th.text}');
                storePosition();
                final snackBar = SnackBar(
                  content: const Text('เพิ่มรายการเรียบร้อยแล้ว'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context, 'store');
              },
              child: Text(
                "บันทึก",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> storePosition() async {
    final url = Uri.parse('https://1683-2001-fb1-13c-6198-c08b-396b-aac7-e2ce.ap.ngrok.io/app/department');
    final headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
    };
    final body = jsonEncode({
      'dept_name_en': dept_name_en.text,
      'dept_name_th': dept_name_th.text,
    });
    final response = await http.post(url, headers: headers, body: body);
    print('------result-------');
    print(response.body);
  }
}

Widget mySizedBoxSmall() {
  return SizedBox(
    height: 20,
  );
}
