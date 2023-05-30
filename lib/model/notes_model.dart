class NotesImpNames{

  static final String id = "id";
  static final String pin = "pin";
  static final String isArchive = "isArchive";
  static final String title = "title";
  static final String content= "content";
  static final String createdTime = "createdTime";
  static final String table = "Notes";

  static final List<String> values = [id,isArchive,pin,title,content,createdTime];
}



class MyNotesModel {

 final int? id;
 final bool pin;
 final bool isArchive;
 final String title;
 final String content;
 final DateTime createdTime;

 MyNotesModel({
  this.id, required this.pin, required this.isArchive, required this.title, required this.content, required this.createdTime
 });


  //Converted data json to map
  static MyNotesModel fromJson(Map<String, Object?> json) 
  {
      return MyNotesModel(id: json[NotesImpNames.id] as int, content: json[NotesImpNames.content] as String, 
      pin: json[NotesImpNames.pin] == 1, isArchive: json[NotesImpNames.isArchive] == 1 , title: json[NotesImpNames.title] as String , 
      createdTime: DateTime.parse(json[NotesImpNames.createdTime] as String)
      );
}

  //Converted data map to json
  Map<String, Object?> toJson(){
    return {
      NotesImpNames.id :  id,
      NotesImpNames.title : title,
      NotesImpNames.content : content,
      NotesImpNames.createdTime : createdTime.toIso8601String(),
      NotesImpNames.pin : pin ? 1 : 0,
      NotesImpNames.isArchive : isArchive ? 1 : 0
    };
  }

  MyNotesModel copy({int? id,
    String? title,
    String? content,
    bool? pin,
    bool? isArchive,
    DateTime? createdTime}){
      
    return MyNotesModel(pin: pin ?? this.pin,isArchive: isArchive ?? this.isArchive, title: title ?? this.title, content: content ?? this.content, createdTime: createdTime ?? this.createdTime);
  }

}