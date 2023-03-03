import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_hrm/pages/position.dart';
import 'package:http/http.dart' as http;
import 'package:app_hrm/pages/add.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Department extends StatefulWidget {
  const Department({super.key});

  @override
  State<Department> createState() => _DepartmentState();
}

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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  gettodolist();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
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
              'HRM แผนก',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),

      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           setState(() {
      //             gettodolist();
      //           });
      //         },
      //         icon: Icon(
      //           Icons.refresh,
      //           color: Colors.white,
      //         ))
      //   ],
      //   title: Text("แผนก"),
      // ),
      body: Department(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()))
              .then((value) {
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
                  IconData(0xf7c8, fontFamily: 'MaterialIcons'),
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

  Future gettodolist() async {
    List alltodo = [];

    var url = Uri.http('127.0.0.1:8000', '/app');
    var response = await http.get(url);
    final result = utf8.decode(response.bodyBytes);

    print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }

  Future deleteDepartment(int dept_id) async {
    print(dept_id);
    var url = Uri.http('127.0.0.1:8000', '/app/department/$dept_id');
    var response = await http.delete(url);
  }
}
