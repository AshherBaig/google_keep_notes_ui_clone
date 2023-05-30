import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';
import 'package:google_keep_notes_ui_clone/createnote.dart';
import 'package:google_keep_notes_ui_clone/model/notes_model.dart';
import 'package:google_keep_notes_ui_clone/search_page.dart';
// import 'package:google_keep_notes_ui_clone/services/db.dart';
import 'package:google_keep_notes_ui_clone/sidebar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_keep_notes_ui_clone/services/database.dart';

import 'noteview.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  late List<MyNotesModel> noteList=  const AsyncSnapshot.waiting() as List<MyNotesModel>;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // noteList = await getAllNotes();
    // print(noteList);
    // createEntry(MyNotesModel(isArchive: false ,pin: false, title: "FLUTTER DEVELOPMENT", content: "Every successful journey begin with first step", createdTime: DateTime.now()));
      // print(noteList);
      getAllNotes();
//    print(noteList);
    // deleteRow();
    // getOneNote();
    // updateOneNote();
    // getOneNote();
}

  Future deleteRow(MyNotesModel note) async {
    await MyNotesDatabase.instance.deleteRow(note);
  }

  Future createEntry(MyNotesModel note) async {
    await MyNotesDatabase.instance.InsertEntry(note);
  }

  Future<List<MyNotesModel>> getAllNotes() async {
      this.noteList = await MyNotesDatabase.instance.readAllNotes();
      
    setState(() {
      isLoading = false;
    });

    return noteList;
  }

  Future getOneNote(int id) async {
    await MyNotesDatabase.instance.readOneNote(id);
  }

  Future updateOneNote(MyNotesModel note) async {
    var row = await MyNotesDatabase.instance.updateNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading || noteList.isEmpty
        ? const Scaffold(
            backgroundColor: bgColor,
            body: Center(
                child: CircularProgressIndicator(
              color: white,
            )),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: cardColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateNote()));
                },
                child: Icon(
                  Icons.add,
                  size: 45,
                )),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: MySideBar(),
            backgroundColor: bgColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 3,
                                color: black.withOpacity(0.2))
                          ],
                          // border: Border.all(color: Colors.white),
                          color: cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _drawerKey.currentState?.openDrawer();
                                },
                                icon: Icon(Icons.menu),
                                color: white,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));
                                },
                                child: const Text(
                                  "Search Your Notes",
                                  style: TextStyle(color: Colors.white60),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) =>
                                                  white.withOpacity(0.1)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)))),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.grid_view,
                                    color: white,
                                  )),
                              Container(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04),
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    NoteSectionAll(),
                    NoteListSection()
                  ],
                ),
              ),
            ));
  }

  Widget NoteSectionAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "All",
            style: TextStyle(fontSize: 16, color: white),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemCount: noteList.length,
            crossAxisCount: 4,
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteView(
                                note: noteList[index],
                              )));
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            noteList[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            noteList[index].content.length > 250
                                ? "${noteList[index].content.substring(0, 250)}..."
                                : noteList[index].content,
                            style: TextStyle(color: white, fontSize: 14),
                          )
                        ])),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget NoteListSection() {
    String note =
        "This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note";
    String note1 =
        "This is Note This is Note This is Note This is Note This is Note This is Note This is Note ";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Note List",
            style: TextStyle(fontSize: 16, color: white),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HEADING",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (index.isEven)
                              ? note.length > 250
                                  ? "${note.substring(0, 250)}..."
                                  : note
                              : note1,
                          style: TextStyle(color: white),
                        )
                      ]));
            },
          ),
        ),
      ],
    );
  }

}