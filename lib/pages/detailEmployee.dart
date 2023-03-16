import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'editEmployee.dart';

class DetailEmployeePage extends StatefulWidget {
  final v1;
  const DetailEmployeePage(this.v1);

  @override
  State<DetailEmployeePage> createState() => _DetailEmployeePageState();
}

const IconData myIcon1 = IconData(0xe491, fontFamily: 'MaterialIcons');
const IconData myIcon2 =
    IconData(0xf498, fontFamily: 'MaterialIcons', matchTextDirection: true);
const IconData myIcon3 = IconData(0xe11b, fontFamily: 'MaterialIcons');

class _DetailEmployeePageState extends State<DetailEmployeePage> {
  var _v1;
  String _fullnameTH = '';
  String _fullnameEN = '';
  String _nickname = '';
  String _phone = '';
  String _email = '';
  String _id_card = '';
  String _company = '';
  String _start_date = '';
  String _emp_type = '';
  String _department = '';
  String _position = '';
  String _birthday = '';

  void initState() {
    super.initState();
    getUser();
    _v1 = widget.v1;
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getUser();
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
        title: Text("รายละเอียดพนักงาน"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteUser(_v1);
              final snackBar = SnackBar(
                content: const Text('ลบรายการเรียบร้อยแล้ว'),
              );
              Navigator.pop(context, 'Item Deleted');
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              myIcon1,
              color: Colors.cyan[100],
              size: 100,
            ),
            Text(
              " " + _fullnameTH,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "(" + _nickname + ")",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(" " + _fullnameEN,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 46, 53, 121))),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              myIcon2,
                              color: Color.fromARGB(255, 46, 53, 121),
                              size: 30,
                            )),
                        TextSpan(
                            text: " ข้อมูลส่วนตัว",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 46, 53, 121),
                            )),
                      ],
                    ),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    " เบอร์โทร: " + _phone,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " อีเมล: " + _email,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " วันเกิด: " + _birthday,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text.rich(TextSpan(children: <InlineSpan>[
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          myIcon3,
                          color: Color.fromARGB(255, 46, 53, 121),
                          size: 30,
                        )),
                    TextSpan(
                        text: " ข้อมูลในบริษัท ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 46, 53, 121),
                        )),
                  ])),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    " บริษัท: " + _company,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " วันที่เริ่มทำงาน :" + _start_date,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " แผนก :" + _department,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " ตำแหน่ง : " + _position,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    " ประเภทพนักงาน: " + _emp_type,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getUser() async {
    try {
      var url = Uri.http('127.0.0.1:8000', '/app/employee/$_v1/edit');
      Map<String, String> header = {"Content-type": "application/json"};
      var response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        final fullname_th = result['data']['ud_fullname_th'];
        final fullname_en = result['data']['ud_fullname_en'];
        final nickname = result['data']['ud_nickname'];
        final phone = result['data']['ud_phone'];
        final email = result['data']['ud_email'];
        final id_card = result['data']['ud_id_card'];
        final company = result['data']['user_company'];

        final birthday = result['data']['ud_birthday'];
        final start_date = result['data']['ud_birthday'];

        final emp_type = result['data']['emp_type'];
        final department = result['data']['dept_name_en'];
        final position = result['data']['position_name'];
        setState(() {
          _fullnameTH = fullname_th;
          _fullnameEN = fullname_en;
          _nickname = nickname;
          _phone = phone;
          _email = email;
          _id_card = id_card;
          _company = company;
          _birthday = birthday;
          _start_date = start_date;
          _emp_type = emp_type;
          _department = department;
          _position = position;
        });
      } else {
        // Handle HTTP error
        print('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
    }
  }

  Future deleteUser(user_id) async {
    var url = Uri.http('127.0.0.1:8000', '/app/employee/${user_id}');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('------result-------');
    print(response.body);
  }
}
