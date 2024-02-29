import 'package:flutter/material.dart';
import 'package:flutter_application_2222/screen/splash.dart';

const saveName = 'userLoggedIn';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}
