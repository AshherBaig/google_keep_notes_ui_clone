import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/home.dart';

void main(){
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomePage(),
    );
  }
}
