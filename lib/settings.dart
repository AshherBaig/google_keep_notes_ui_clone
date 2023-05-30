import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Settings", style: TextStyle(color: white),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
        children: [
          Text("Sync", style: TextStyle(color: white, fontSize: 16),),
         Spacer(), 
          Transform.scale
          (
          scale: 1,
            child: Switch.adaptive(value: value, onChanged: (switchValue){
              setState(() {
                this.value = switchValue;
              });
            }),
          )
        ],),
      ),
    );
  }
}