import 'package:app_hrm/pages/department.dart';
import 'package:app_hrm/pages/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List departmentList = [];
  int _currentIndex = 0;
  final tabs = [Department(), Employee()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors
                  .transparent, // set to transparent to see the gradient effect
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
}
