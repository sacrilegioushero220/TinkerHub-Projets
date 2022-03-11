import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/database_provider.dart';
import 'package:flutter_diary_app/screens/add_note.dart';
import 'package:flutter_diary_app/screens/dashboard.dart';
import 'package:flutter_diary_app/screens/display_note.dart';
import 'package:flutter_diary_app/providers/auth_provider.dart';
import 'package:flutter_diary_app/providers/user_provide.dart';
import 'package:flutter_diary_app/screens/login.dart';
import 'package:flutter_diary_app/screens/register.dart';

import 'package:flutter_diary_app/utility/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'domain/user.dart';
import 'model/note_model.dart';
import 'screens/add_note.dart';
import 'package:intl/intl.dart';

void main() {
  Text('1');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Future<User> getUserData () => UserPreferences().getUser();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> AuthProvider()),
          ChangeNotifierProvider(create: (_)=>UserProvider())
        ],
      child:  MaterialApp(
        title: 'Login Registration',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data.token == null)
                    return Login();
                  else
                    Provider.of<UserProvider>(context).setUser(snapshot.data);
                    return HomeScreen();

              }
            }),
        routes: {
          '/login':(context)=>Login(),
          '/register':(context)=>Register(),
          '/HomeScreen':(context)=>HomeScreen(),
        "/AddNote": (context) => AddNote(),
        "/DisplayNote": (context) => DisplayNote(),
        },
      ),
    );


  }
}