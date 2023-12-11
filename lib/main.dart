import 'package:flutter/material.dart';
import 'package:login_screen/loginScreen.dart';
import 'package:login_screen/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
