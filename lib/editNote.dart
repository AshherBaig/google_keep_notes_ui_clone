import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';
import 'package:google_keep_notes_ui_clone/home.dart';
import 'package:google_keep_notes_ui_clone/noteview.dart';
import 'package:google_keep_notes_ui_clone/services/database.dart';

import 'model/notes_model.dart';

class EditNote extends StatefulWidget {
  MyNotesModel note;
  EditNote({super.key, required this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late String newTitle = const AsyncSnapshot.waiting() as String;
  late String newDetail = const AsyncSnapshot.waiting() as String;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newTitle = widget.note.title.toString();
    newDetail = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () async {
                MyNotesModel newNote = MyNotesModel(
                    id: widget.note.id,
                    isArchive: widget.note.isArchive,
                    pin: widget.note.pin,
                    title: newTitle,
                    content: newDetail,
                    createdTime: widget.note.createdTime);
                await MyNotesDatabase.instance.updateNote(newNote);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()));
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                initialValue: newTitle,
                onChanged: (value) {
                  newTitle = value;
                },
                cursorColor: white,
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 20),
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle:
                        TextStyle(color: white.withOpacity(0.4), fontSize: 20)),
              ),
            ),
            Container(
                height: 300,
                child: Form(
                  child: TextFormField(
                    initialValue: newDetail,
                    onChanged: (value) {
                      newDetail = value;
                    },
                    cursorColor: white,
                    style: TextStyle(color: white, fontSize: 16),
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Note",
                        hintStyle: TextStyle(
                            color: white.withOpacity(0.4), fontSize: 16)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
