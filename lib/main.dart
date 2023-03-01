import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/singin_screen.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme : ThemeData(
        primarySwatch: Colors.blue,
      ),
      title:'Flutter Demo',
      home : const SignInScreen(),
    );

    throw UnimplementedError();
  }

}