import 'package:flutter/material.dart';
import 'package:google_keep_notes_ui_clone/archive.dart';
import 'package:google_keep_notes_ui_clone/colors.dart';
import 'package:google_keep_notes_ui_clone/settings.dart';

class MySideBar extends StatelessWidget {
  const MySideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: Text("Google Keep", style: TextStyle(color: white, fontSize: 25),)),
                Divider(color: white.withOpacity(0.3),),
                MyDrawerSection(Icons.lightbulb, "Notes"),
                MyDrawerSectionTwo(context),
                MyDrawerSectionThree(context),
               

                
            ],
          ),
        ),
      ),
    );
  }


Widget MyDrawerSection(IconData? icon, String text,) {
  return Container(
                  margin: EdgeInsets.only(right: 15, left: 7),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50))
                      ))
                    ),
                    onPressed: (){},
                    child: Row(
                      children: [
                        Icon(icon, color: white.withOpacity(0.7),size: 26,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(text, style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),),
                        )
                      ],
                    ),
                  ),
                );
}


Widget MyDrawerSectionTwo(context) {
  return Container(
                  margin: EdgeInsets.only(right: 15, left: 7),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ArchiveView()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.archive_outlined, color: white.withOpacity(0.7),size: 26,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Archive", style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),),
                        )
                      ],
                    ),
                  ),
                );
}

Widget MyDrawerSectionThree(context) {
  return Container(
                  margin: EdgeInsets.only(right: 15, left: 7),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsView()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: white.withOpacity(0.7),size: 26,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Settings", style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),),
                        )
                      ],
                    ),
                  ),
                );
}


}
