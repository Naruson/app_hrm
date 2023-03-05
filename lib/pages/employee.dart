import 'dart:convert';
import 'package:app_hrm/pages/createEmployee.dart';
import 'package:app_hrm/pages/employeeEdit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_hrm/pages/position.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  List employeeList = [];
  Color myColor = Color(int.parse("2E3579", radix: 16));
  // List datalistItem = ["Book 01", "Book 02", "Book 03", "Book 04", "Book 05"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployee();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Employee(),
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
            getEmployee();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget Employee() {
    return ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: Icon(
                  IconData(0xf7c8, fontFamily: 'MaterialIcons'),
                  color: Colors.cyan[200],
                ),
                title: Text("${employeeList[index]['ud_fullname_th']}"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeEditPage(
                              employeeList[index]['ud_fullname_th'],
                              employeeList[index]['ud_fullname_en'],
                              employeeList[index]['ud_phone'],
                              employeeList[index]['ud_nickname'],
                              employeeList[index]['ud_birthday'],
                              employeeList[index]['id']))).then((value) {
                    setState(() {
                      print(value);
                      getEmployee();
                    });
                  });
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        deleteUser(employeeList[index]['id']);
                        final snackBar = SnackBar(
                          content: const Text('ลบรายการเรียบร้อยแล้ว'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        getEmployee();
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
                )),
          );
        });
  }

  Future<void> getEmployee() async {
    try {
      var url = Uri.http('127.0.0.1:8000', '/app/employee');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result['data'];
        // print(data);

        setState(() {
          employeeList = data;
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
