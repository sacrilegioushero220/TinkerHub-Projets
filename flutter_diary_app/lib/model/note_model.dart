class NoteModel {
  int id;
  String title;
  String body;
  DateTime creationDate;
  NoteModel(
      {
        required this.id ,
      required this.title ,
      required this.body ,
      required this.creationDate});

  //function to convert our item into a map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creation_date": creationDate
    });
  }
}
