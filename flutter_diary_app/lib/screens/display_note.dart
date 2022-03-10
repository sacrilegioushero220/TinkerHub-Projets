import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/database_provider.dart';
import 'package:flutter_diary_app/model/note_model.dart';
import 'package:intl/intl.dart';

class DisplayNote extends StatelessWidget {
  const DisplayNote({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i;
    final NoteModel note =
        ModalRoute.of(context).settings.arguments as NoteModel;

    return Scaffold(
        appBar: AppBar(
          title: Text(DateFormat('EEE, dd-MM-yyyy').format(note.creationDate)),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                DatabaseProvider.db.deleteNote(note.id);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(note.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 16.0),
                Text(note.body, style: TextStyle(fontSize: 18.0))
              ],
            )));
  }
}
