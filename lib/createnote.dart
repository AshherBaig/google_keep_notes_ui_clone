import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';
import 'package:google_keep_notes_ui_clone/model/notes_model.dart';
import 'package:google_keep_notes_ui_clone/services/database.dart';

import 'home.dart';

class CreateNote extends StatefulWidget {
   CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: bgColor,
          elevation: 0.0,
          actions: [
            IconButton(onPressed: ()async{
                await MyNotesDatabase.instance.InsertEntry(MyNotesModel(pin: false, isArchive: false,title: title.text, content: content.text, createdTime: DateTime.now()));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (content) => HomePage()));
            }, icon: Icon(Icons.save))
          ],
        ),
      
        body: Container(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            children: [
            TextField(
              controller: title,
              cursorColor: white,
              style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(color: white.withOpacity(0.4), fontSize: 20)
              ),
            ),
            Container(
              height: 300,
              child: TextField(
                controller: content,
                cursorColor: white,
                style: TextStyle(color: white,fontSize: 16),
                decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Note",
                hintStyle: TextStyle(color: white.withOpacity(0.4), fontSize: 16)
              ),
              )),
            ],
          ),
        ),
      );
  }
}