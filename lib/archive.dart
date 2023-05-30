import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';
import 'package:google_keep_notes_ui_clone/createnote.dart';
import 'package:google_keep_notes_ui_clone/sidebar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'noteview.dart';

class ArchiveView extends StatelessWidget {
  
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    
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
                          Text(
                            "Search Your Notes",
                            style: TextStyle(color: Colors.white60),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => white.withOpacity(0.1)),
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
                                  right:
                                      MediaQuery.of(context).size.width * 0.04),
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

  Widget NoteSectionAll(){
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
                    "All",
                    style: TextStyle(fontSize: 16 ,color: white),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    itemCount: 10,
                    crossAxisCount: 4,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteView()));
                        },
                        child: Container(
                          
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "HEADING",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18,
                                        color: white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    (index.isEven) ? note.length > 250 ? "${note.substring(0,250)}..." : note : note1,
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


  Widget NoteListSection()
  {
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
                    style: TextStyle(fontSize: 16 ,color: white),
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
                        margin: EdgeInsets.only(bottom:10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "HEADING",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  (index.isEven) ? note.length > 250 ? "${note.substring(0,250)}..." : note : note1,
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
