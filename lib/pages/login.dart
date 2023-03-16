import 'package:app_hrm/main.dart';
import 'package:app_hrm/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;
  // String baseUrl = DotEnv().env['BASE_URL'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'เข้าสู่ระบบ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Image.network(
              '${dotenv.env['BASE_URL']}/files/image/logo/logo.png',
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TextField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Color(0xFF005FBC)),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'รหัสผ่าน',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF005FBC),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xFF005FBC),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                    onPressed: login,
                    child: Text(
                      "เข้าสู่ระบบ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF005FBC)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 120)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(8),
                      shadowColor:
                          MaterialStateProperty.all(Colors.grey.shade400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setToken(textStatus) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', textStatus);
  }

  Future<void> login() async {
    print('${password.text} username: ${username.text}');
    final url = Uri.parse('${dotenv.env['BASE_URL']}/auth/login');
    final response = await http.post(
      url,
      body: json.encode({
        'user_username': '${username.text}',
        'user_password': '${password.text}',
      }),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    print(response);
    if (response.statusCode == 200) {
      // Login successful
      final responseData = json.decode(response.body);
      final accessToken = responseData['data']['access_token'];
      await setToken(accessToken);
      print(responseData);

      // Navigate to IndexPage
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => IndexPage()));
    } else {
      // Login failed
      print('Error: ${response.statusCode}');
      // Login failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Authentication Failed',
                style: TextStyle(color: Colors.red)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'We couldn\'t log you in.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Please check your username and password and try again.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
