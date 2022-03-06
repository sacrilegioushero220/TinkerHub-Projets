import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/database_provider.dart';
import 'package:flutter_diary_app/model/note_model.dart';

class AddNote extends StatefulWidget {
  AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  // creating addNote Function
  String title;
  String body;
  DateTime date;
  //the input controller
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  AddNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
    print("Saved succesfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note",
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
              date = DateTime.now();
            });
            NoteModel note =
                NoteModel(title: title, body: body, creationDate: date);
            AddNote(note);
            // when the note is saved it will return automatically to homepage
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          label: Text("Save"),
          icon: Icon(Icons.save)),
    );
  }
}
