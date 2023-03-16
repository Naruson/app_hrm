import 'package:app_hrm/pages/department.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({Key? key}) : super(key: key);

  @override
  State<CreateEmployeePage> createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage> {
  List<dynamic> departmentList = [];
  List<dynamic> positionList = [];
  List<dynamic> empTypeList = [];
  TextEditingController fullname_th = TextEditingController();
  TextEditingController fullname_en = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController id_card = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController emp_id = TextEditingController();
  TextEditingController password = TextEditingController();
  var emp_type = null;
  var department = null;
  var position = null;
  final TextEditingController _birthday = TextEditingController();
  final TextEditingController _start_date = TextEditingController();
  late DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  int _currentStep = 0;
  final _controller = TextEditingController();

// void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
  @override
  void initState() {
    // TODO: implement initState
    getDepartment();
    getEmployeeType();
    super.initState();
  }

  void addPosition() {
    if (department != null) {
      getPosition();
    }
  }

  void _selectDate1() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date to today's date
      firstDate: DateTime(1900), // Set the minimum date to January 1st, 1900
      lastDate: DateTime(2100),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
        _birthday.text = formattedDate;
        print(_birthday.text);
      });
    }
  }

  void _selectDate2() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date to today's date
      firstDate: DateTime(1900), // Set the minimum date to January 1st, 1900
      lastDate: DateTime(2100),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
        _start_date.text = formattedDate;
        print(_start_date.text);
      });
    }
  }

  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  List<Step> stepList() => [
        // This is step1 which is called Account.
        // Here we will fill our personal details
        Step(
          state: _currentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 0,
          title: const Text('ข้อมูลส่วนตัว'),
          content: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: fullname_th,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อ-นามสกุลไทย',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: fullname_en,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อ-นามสกุลอังกฤษ',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: nickname,
                  decoration: const InputDecoration(
                    labelText: 'ชื่อเล่น',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'วันเดือนปีเกิด',
                  ),
                  controller: _birthday,
                  onTap: _selectDate1,
                  readOnly: true,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                    labelText: 'เบอร์โทรศัพท์',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'อีเมล',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: id_card,
                  decoration: const InputDecoration(
                    labelText: 'รหัสบัตรประชาชน',
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),

        Step(
            state: _currentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 1,
            title: const Text('ข้อมูลในบริษัท'),
            content: Container(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'ประเภทพนักงาน',
                    ),
                    items: empTypeList.map((item) {
                      return new DropdownMenuItem(
                          child: new Text(
                            item['user_contract_name'],
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: item['user_contract_type'].toString());
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        emp_type = value;
                        print("emp_type: " + emp_type.toString());
                      });
                    },
                    value: emp_type,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'แผนก',
                    ),
                    items: departmentList.map((item) {
                      return new DropdownMenuItem(
                          child: new Text(
                            item['dept_name_en'],
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: item['dept_id'].toString());
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        department = value;
                        print("department: " + department);
                        addPosition();
                      });
                    },
                    value: department,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'ตำแหน่ง',
                    ),
                    items: positionList.map((item) {
                      return new DropdownMenuItem(
                          child: new Text(
                            item['dp_name_en'],
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          value: item['dp_id'].toString());
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        position = value;
                        print("Position: " + position);
                        addPosition();
                      });
                    },
                    value: position,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'วันที่เริ่มงาน',
                    ),
                    controller: _start_date,
                    onTap: _selectDate2,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )),

        Step(
            state: _currentStep <= 2 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 2,
            title: const Text('ข้อมูลผู้ใช้'),
            content: Container(
              child: Column(
                children: [
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        labelText: 'ชื่อผู้ใช้ระบบ',
                        suffixIcon: IconButton(
                            onPressed: () {
                              final data = ClipboardData(text: username.text);
                              Clipboard.setData(data);

                              final snackbar =
                                  SnackBar(content: Text("Username Copy"));

                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(snackbar);
                            },
                            icon: Icon(Icons.copy))),
                  ),

                  SizedBox(height: 30),
                  TextFormField(
                    // readOnly: true,
                    controller: _controller,
                    decoration: InputDecoration(
                        labelText: 'รหัสผ่าน',
                        suffixIcon: IconButton(
                            onPressed: () {
                              final data =
                                  ClipboardData(text: _controller.text);
                              Clipboard.setData(data);

                              final snackbar =
                                  SnackBar(content: Text("Password Copy"));

                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(snackbar);
                            },
                            icon: Icon(Icons.copy))),
                  ),
                  SizedBox(height: 10),
                  buildButtonWidget(),
                  // ElevatedButton(
                  //   // onPressed: ,
                  //   child: const Text('Save'),
                  // ),
                  SizedBox(height: 40),
                ],
              ),
            )),
      ];

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
        title: Text("เพิ่มรายชื่อ"),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: stepList(),
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                if (_currentStep != 2)
                  ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: const Text('NEXT'),
                  ),
                if (_currentStep == 2)
                  ElevatedButton(
                    onPressed: () async {
                      await addUser();
                      final snackBar = SnackBar(
                          content: const Text('เพิ่มรายการเรียบร้อยแล้ว'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context, 'create');
                    },
                    child: const Text('Save'),
                  ),
                if (_currentStep > 0 && _currentStep <= 1)
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child: const Text(
                      'BACK',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          );
        },
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: () {
          setState(() {
            if (_currentStep < (stepList().length - 1)) {
              _currentStep += 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        currentStep: _currentStep,
      ),
    );
  }

  Widget buildButtonWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
              onPressed: () {
                final password = generatePassword();
                _controller.text = password;
              },
              child: Text(
                "Generate",
                style: TextStyle(color: Colors.white),
              )),
        ));
  }

  Future<void> getDepartment() async {
    try {
      var url =
          Uri.parse('${dotenv.env['BASE_URL']}/app/employee/createDepartment');
      var response =
          await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result['data'];

        setState(() {
          departmentList = data;
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

  Future<void> getEmployeeType() async {
    try {
      var url = Uri.parse('${dotenv.env['BASE_URL']}/app/employee/create');
      var response =
          await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result['data'];

        setState(() {
          empTypeList = data;
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

  Future<void> getPosition() async {
    try {
      var url = Uri.parse(
          '${dotenv.env['BASE_URL']}/app/department/$department/position');
      var response =
          await http.get(url, headers: {'ngrok-skip-browser-warning': 'true'});

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result['data'];

        setState(() {
          positionList = data;
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

  Future addUser() async {
    try {
      var url = Uri.parse('${dotenv.env['BASE_URL']}/app/employee');
      Map<String, String> header = {
        "Content-type": "application/json",
        'ngrok-skip-browser-warning': 'true',
      };
      String jsondata =
          '{"fullname_th":"${fullname_th.text}","fullname_en":"${fullname_en.text}","phone":"${phone.text}","nickname":"${nickname.text}","birthday" : "${_birthday.text}","email":"${email.text}","dept_id":"${department}", "dp_id":"${position}","user_contract_type":"${emp_type}","user_username":"${username.text}","user_password":"${_controller.text}","user_start_date":"${_start_date.text}","ud_id_card":"${id_card.text}"}';

      var response = await http.post(url, headers: header, body: jsondata);

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

String generatePassword({
  bool letter = true,
  bool isNumber = true,
  bool isSpecial = true,
}) {
  final length = 8;
  final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
  final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final number = '0123456789';
  final special = '@#%^*>\$@?/[]=+';

  String chars = "";
  if (letter) chars += '$letterLowerCase$letterUpperCase';
  if (isNumber) chars += '$number';
  if (isSpecial) chars += '$special';

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join('');
}
