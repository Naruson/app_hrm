import 'package:app_hrm/pages/department.dart';
import 'package:app_hrm/pages/employee.dart';
import 'package:app_hrm/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexPage extends StatefulWidget {
  //const CreateEmployeePage({ Key? key }) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  String? accessToken = '';
  List departmentList = [];
  int _currentIndex = 0;
  final tabs = [Department(), Employee()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
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
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    '../../assets/image/logo.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'HRM',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    logout();
                  },
                ),
              ],
            ),
            body: tabs[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.local_fire_department_sharp),
                      label: "Department"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people), label: "Employee"),
                ],
                onTap: (index) {
                  setState(() {
                    print(index);
                    _currentIndex = index;
                  });
                })));
  }

  Future<void> logout() async {
    try {
      await getPassword();
      print('my token is: $accessToken');
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8000/auth/logout'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        // Logout successful, perform any necessary actions
        print('Logout successful');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        // Handle unsuccessful logout
        print('Logout unsuccessful with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error occurred during logout: $e');
    }
  }

  Future<void> getPassword() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('accessToken');
    print(token);
    accessToken = token;
  }
}
