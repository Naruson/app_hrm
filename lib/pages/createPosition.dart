import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CreatePositionPage extends StatefulWidget {
  // const UpdatePage({ Key? key }) : super(key: key);
  final v1;
  const CreatePositionPage(this.v1);
  @override
  State<CreatePositionPage> createState() => _CreatePositionPageState();
}

class _CreatePositionPageState extends State<CreatePositionPage> {
  TextEditingController position_en = TextEditingController();
  TextEditingController position_th = TextEditingController();

  var _v1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
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
              controller: position_en,
              decoration: const InputDecoration(
                labelText: 'ชื่อภาษาอังกฤษ',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: position_th,
              decoration: const InputDecoration(
                labelText: 'ชื่อภาษาไทย',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                print('title: ${position_en.text}');
                print('detail: ${position_th.text}');
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
    final url = Uri.parse('${dotenv.env['BASE_URL']}/app/department/position');
    final headers = {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
    };
    final body = jsonEncode({
      'dept_id': '$_v1',
      'position_en': position_en.text,
      'position_th': position_th.text,
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
