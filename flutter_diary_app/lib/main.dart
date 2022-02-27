import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/database_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //We will use routes to navigate between screens
      initialRoute: "/",
      routes: {"/": (context) => HomeScreen()},
      title: 'A Diary Entry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      title: Text("Your Diary Entries"),
    )
    body: FutureBuilder(
      future: getNotes(),
      builder: (context, noteData){
        switch(noteData.connectionState){
          case ConnectionState.waiting:
          {
            return Center(child: CircularProgressIndicator());
          }
          case ConnectionState.done:
          {
            //Checking we didnts get a null
            if(noteData.data == Null){
              return Center(child: Text("You don't have any notes yet, create one"),
              );
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: noteData.data.length,
                  itemBuilder: (context, index){
                    //setting the different items
                    String title =noteData.data[index]['title'];
                    String body =noteData.data[index]['body'];
                    String creation_date =noteData.data[index]['creation_date'];
                    int id =noteData.data[index]['id'];
                    return Card(child: ListTile(
                         title: Text(title),
                         subtitle: Text(body),
                    ),);
                  },
                ),
                );
            }
    
          }
        }
      }
    ),
    );
  }
}
