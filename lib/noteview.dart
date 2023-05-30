import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';
import 'package:google_keep_notes_ui_clone/editNote.dart';
import 'package:google_keep_notes_ui_clone/home.dart';
import 'package:google_keep_notes_ui_clone/services/database.dart';

import 'model/notes_model.dart';

class NoteView extends StatefulWidget {
  MyNotesModel note;
  NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await MyNotesDatabase.instance.pinNote(widget.note);
                // print(widget.note.pin);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: widget.note.pin == false
                  ? Icon(Icons.push_pin_outlined)
                  : Icon(Icons.push_pin)),
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await MyNotesDatabase.instance.archNote(widget.note);
              Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: widget.note.isArchive
                ? Icon(Icons.archive)
                : Icon(Icons.archive_outlined),
          ),
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await MyNotesDatabase.instance.deleteRow(widget.note);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.delete_forever_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNote(
                              note: widget.note,
                            )));
              },
              icon: Icon(Icons.edit_outlined)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.note.content,
              style: TextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
