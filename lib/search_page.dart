import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_keep_notes_ui_clone/model/notes_model.dart';
import 'package:google_keep_notes_ui_clone/noteview.dart';
import 'package:google_keep_notes_ui_clone/services/database.dart';

import 'colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<MyNotesModel> SearchResultNote = [];
  bool isLoading = false;

  void SearchResult(String query) async {
    SearchResultNote.clear();
    setState(() {
      isLoading = true;
    });

    final resultsID = await MyNotesDatabase.instance.getString(query);
    List<MyNotesModel> searchResultNotesLocal = [];
    // print(resultsID);
    resultsID.forEach((element) async {
      final searchNote = await MyNotesDatabase.instance.readOneNote(element);
      searchResultNotesLocal.add(searchNote!);

      setState(() {
        SearchResultNote.add(searchNote);
        
      });
    });

    setState(() {
      isLoading = false;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(color: white.withOpacity(0.1)),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: white),
                      ),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(color: white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search Your Notes",
                            hintStyle: TextStyle(
                                color: white.withOpacity(0.5), fontSize: 16),
                          ),
                          onSubmitted: (value) {
                            print(SearchResultNote);
                            setState(() {
                              SearchResult(value.toLowerCase());
                            });
                            
                          },
                        ),
                      )
                    ],
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: white,
                          ),
                        )
                      : NoteSectionAll(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget NoteSectionAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "SEARCH RESULTS",
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
            itemCount: SearchResultNote.length,
            crossAxisCount: 4,
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NoteView(note: SearchResultNote[index])));
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
                            SearchResultNote[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            SearchResultNote[index].content.length > 250
                                ? "${SearchResultNote[index].content.substring(0, 250)}..."
                                : SearchResultNote[index].content,
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
}
