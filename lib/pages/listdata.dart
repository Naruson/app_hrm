import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_hrm/pages/update.dart';
import 'package:http/http.dart' as http;
import 'package:app_hrm/pages/add.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List todolistitems = [];
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
        title: Text("แผนก"),
      ),
      body: listData(),
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

  Widget listData() {
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
            // onTap: () {
            //   {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => UpdatePage(
            //                 todolistitems[index]['dept_id'],
            //                 todolistitems[index]['dept_name_en'],
            //                 todolistitems[index]['dept_name_th']))).then((value) {
            //       setState(() {
            //         print(value);
            //         if (value == 'delete') {
            //           final snackBar = SnackBar(
            //             content: const Text('ลบรายการเรียบร้อยแล้ว'),
            //           );
            //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //         }
            //         gettodolist();
            //       });
            //     });
            //   }
            // },
            trailing: Icon(Icons.more_vert),
          ));
        });
  }

  Future gettodolist() async {
    List alltodo = [];

    var url = Uri.http('127.0.0.1:8000', '/FlutterApi');
    var response = await http.get(url);
    final result = utf8.decode(response.bodyBytes);
    //  "[" + response.body + "]";
    // utf8.decode(response.bodyBytes);
    
    print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}
