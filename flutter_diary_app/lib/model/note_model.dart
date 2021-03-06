class NoteModel {
  final int id;
  final String title;
  final String body;
  // ignore: non_constant_identifier_names
  final DateTime creationDate;
  // ignore: non_constant_identifier_names
  NoteModel({this.id, this.title, this.body, this.creationDate});

  //function to convert our item into a map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creationDate": creationDate.toString()
    });
  }
}
