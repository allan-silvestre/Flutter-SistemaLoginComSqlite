import 'package:flutter/material.dart';
import 'package:login/database/dao/userDao.dart';
import 'package:login/models/user.dart';
import 'package:login/screens/login.dart';
import 'package:login/screens/register.dart';

void main() {
  runApp(const MyApp());
  //UserDao().CreateUser( User(id: 1, name: 'n', phone: '(99) 99999 9999', password: 'p')).then((user) => print(user));
  //UserDao().UpdateUser(1, User(id: 1, name: '1', phone: '(99) 99999 9999', password: 'password'));
  //UserDao().DeleteUser(1);
  UserDao().GetUsers().then((user) => print('${user}'));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Login(),
    );
  }
}