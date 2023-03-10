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
  String _position ='';
  String _birthday ='';


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
      body: Column(
        children: [
          Text(_fullnameTH),
        ],
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
      _birthday =birthday;
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

