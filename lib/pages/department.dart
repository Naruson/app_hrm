import 'dart:convert';
import 'package:app_hrm/pages/createDepartment.dart';
import 'package:app_hrm/pages/createEmployee.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_hrm/pages/position.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Department extends StatefulWidget {
  const Department({super.key});

  @override
  State<Department> createState() => _DepartmentState();
}

const IconData myIcon = IconData(0xf7c8, fontFamily: 'MaterialIcons');

class _DepartmentState extends State<Department> {
  List todolistitems = [];
  Color myColor = Color(int.parse("2E3579", radix: 16));
  // List datalistItem = ["Book 01", "Book 02", "Book 03", "Book 04", "Book 05"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettodolist();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Department(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateDepartmentPage())).then((value) {
            setState(() {
              if (value == 'add') {
                final snackBar = SnackBar(
                  content: const Text('เพิ่มรายการเรียบร้อยแล้ว'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
            gettodolist();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget Department() {
    return ListView.builder(
        itemCount: todolistitems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                leading: Icon(
                  myIcon,
                  color: Colors.cyan[200],
                ),
                title: Text("${todolistitems[index]['dept_name_en']}"),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PositionPage(
                                  todolistitems[index]['dept_id'],
                                  todolistitems[index]['dept_name_en'])))
                      .then((value) {
                    setState(() {
                      print(value);
                      if (value == 'delete') {
                        final snackBar = SnackBar(
                          content: const Text('ลบรายการเรียบร้อยแล้ว'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      gettodolist();
                    });
                  });
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('delete');
                        deleteDepartment(todolistitems[index]['dept_id']);
                        gettodolist();
                        // do something when delete icon is pressed
                      },
                      child: Visibility(
                        visible: todolistitems[index]['delete_status'] == true,
                        child: Icon(Icons.delete),
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PositionPage(
                                        todolistitems[index]['dept_id'],
                                        todolistitems[index]['dept_name_en'])))
                            .then((value) {
                          setState(() {
                            print(value);
                            if (value == 'delete') {
                              final snackBar = SnackBar(
                                content: const Text('ลบรายการเรียบร้อยแล้ว'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            gettodolist();
                          });
                        });
                        // do something when more_vert icon is pressed
                      },
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                )),
          );
        });
  }

  Future gettodolist() async {
    List alltodo = [];
    var url = Uri.parse('https://1683-2001-fb1-13c-6198-c08b-396b-aac7-e2ce.ap.ngrok.io/app/department');
    var response =
        await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});
    final result = utf8.decode(response.bodyBytes);

    setState(() {
      todolistitems = jsonDecode(result);
    });
  }

  Future deleteDepartment(int dept_id) async {
    print(dept_id);
    var url = Uri.parse('https://1683-2001-fb1-13c-6198-c08b-396b-aac7-e2ce.ap.ngrok.io/app/department/$dept_id');
    var response =
        await http.delete(url, headers: {'ngrok-skip-browser-warning': 'true'});
  }
}
