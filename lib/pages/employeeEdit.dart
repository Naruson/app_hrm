import 'package:app_hrm/pages/department.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmployeeEditPage extends StatefulWidget {
  //const EmployeeEditPage({ Key? key }) : super(key: key);

  final v1, v2, v3, v4, v5, v6;
  const EmployeeEditPage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6);

  @override
  State<EmployeeEditPage> createState() => _EmployeeEditPageState();
}

class _EmployeeEditPageState extends State<EmployeeEditPage> {
  TextEditingController fullname_th = TextEditingController();
  TextEditingController fullname_en = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  late DateTime _selectedDate;
  // Initial Selected Value
  String dropdownvalue = 'Female';

  var _v1;
  var _v2;
  var _v3;
  var _v4;
  var _v5;
  var _v6;

  @override
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
                  // getPosition();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        title: Text("แก้ไขรายชื่อ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  "ชื่อจริง - ภาษาไทย",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fullname_th,
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
                  ),
                ),
                mySizedBoxSmall(),
                Text(
                  "ชื่อจริง - ภาษาอังกฤษ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fullname_en,
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
                  ),
                ),
                mySizedBoxSmall(),
                Text(
                  "เบอร์โทร",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: phone,
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
                  ),
                ),
                mySizedBoxSmall(),
                Text(
                  "ชื่อเล่น",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nickname,
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
                  ),
                ),
                mySizedBoxSmall(),
                Text(
                  "วันเกิด",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_selectedDate.toLocal()}".split(' ')[0],
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            mySizedBoxSmall(),
            ElevatedButton(
              onPressed: () {
                updateUser();
                final snackBar =
                    SnackBar(content: const Text('อัพเดตรายการเรียบร้อยแล้ว'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context, 'update');
              },
              child: Text("อัปเดต"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 46, 53, 121),
                minimumSize: Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    _v4 = widget.v4;
    _v5 = widget.v5;
    _v6 = widget.v6;

    fullname_th.text = widget.v1;
    fullname_en.text = widget.v2;
    phone.text = widget.v3;
    nickname.text = widget.v4;

    String dateString = widget.v5;
    _selectedDate = DateTime.parse(dateString);
  }

  Future updateUser() async {
    try {
      var url = Uri.http('127.0.0.1:8000', '/app/employee/$_v6');
      Map<String, String> header = {"Content-type": "application/json"};
      String jsondata =
          '{"fullname_th":"${fullname_th.text}", "fullname_en":"${fullname_en.text}", "phone" : "${phone.text}", "nickname" : "${nickname.text}", "birthday" : "${_selectedDate.toString().split(' ')[0]}"}';

      var response = await http.patch(url, headers: header, body: jsondata);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
      } else {
        // Handle HTTP error
        print('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
    }
  }
}

Widget mySizedBoxSmall() {
  return SizedBox(
    height: 20,
  );
}
