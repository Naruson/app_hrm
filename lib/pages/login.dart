// import 'package:flutter/material.dart';
// // import 'package:app_hrm/pages/profile.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   // const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Scaffold(
//         body: ListView(
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               'Login',
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueGrey,
//                   fontSize: 30),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Image.network(
//               'https://cdn-icons-png.flaticon.com/512/295/295128.png',
//               height: 150,
//               width: 150,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             TextField(
//                 controller: username,
//                 decoration: InputDecoration(
//                     labelText: 'UserName', border: OutlineInputBorder())),
//             SizedBox(
//               height: 15,
//             ),
//             TextField(
//                 controller: password,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     labelText: 'Password', border: OutlineInputBorder())),
//             SizedBox(
//               height: 15,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (username.text == 'admin' && password.text == '1234') {
//                   print('USERNAME = admin, PASSWORD = 1234');
//                   setState(() {
//                     username.text = 'admin';
//                     password.text = '1234';

//                     setUsername(username.text);
//                     setPassword(password.text);
//                     setStatus('Login Success');
//                   });
//                 } else {
//                   print('Unauthorize');
//                   setStatus('Login Failed');
//                 }
//               },
//               child: Text("เข้าสู่ระบบ"),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
//                   padding: MaterialStateProperty.all(
//                       EdgeInsets.fromLTRB(50, 20, 50, 20)),
//                   textStyle:
//                       MaterialStateProperty.all(TextStyle(fontSize: 30))),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProfilePage(),
//                     ));
//               },
//               child: Text("ไปหน้า Profile"),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black12),
//                   padding: MaterialStateProperty.all(
//                       EdgeInsets.fromLTRB(50, 20, 50, 20)),
//                   textStyle: MaterialStateProperty.all(
//                       TextStyle(fontSize: 30, color: Colors.red))),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   //unbder _LoginPageState class

//   Future<void> setUsername(textUsername) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('username', textUsername);
//   }

//   Future<void> setPassword(textPassword) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('password', textPassword);
//   }

//   Future<void> setStatus(textStatus) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('status', textStatus);
//   }
// }
