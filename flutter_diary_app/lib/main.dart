import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/database_provider.dart';
import 'package:flutter_diary_app/screens/add_note.dart';
import 'package:flutter_diary_app/screens/display_note.dart';
import 'package:path/path.dart';
import 'model/note_model.dart';
import 'screens/add_note.dart';

void main() {
  Text('1');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //We will use routes to navigate between screens
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/AddNote": (context) => AddNote(),
        "/DisplayNote": (context) => DisplayNote(),
      },
      title: 'A Diary Entry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //getting all notes
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //The future builder to display the element
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Diary Entries'),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            case ConnectionState.done:
              {
                //Checking we didnts get a null
                if (noteData.data == Null) {
                  return Center(
                    child: Text("You don't have any entries yet, create one"),
                  );
                } else {
                  //final data = noteData.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: noteData.data.length,
                      itemBuilder: (context, index) {
                        //setting the different items
                        String title = noteData.data[index]['title'];
                        String body = noteData.data[index]['body'];

                        String creationDate =
                            noteData.data[index]['creationDate'];

                        int id = noteData.data[index]['id'];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/DisplayNote",
                                  arguments: NoteModel(
                                    id: id,
                                    title: title,
                                    body: body,
                                    creationDate: DateTime.parse(creationDate),
                                  ));
                            },
                            title: Text(title),
                            subtitle: Text(body),
                          ),
                        );
                      },
                    ),
                  );
                }
                break;
              }
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
          return Center(
            child: Text("You don't have any notes yet, create one!"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
