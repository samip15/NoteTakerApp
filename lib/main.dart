import 'package:flutter/material.dart';
import 'package:note_taker_app/model/note_model.dart';
import 'package:note_taker_app/widgets/edit_note.dart';
import 'package:note_taker_app/widgets/new_note.dart';
import 'package:note_taker_app/widgets/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.brown,
        accentColor: Colors.green,
        fontFamily: "SourceCodePro",
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
                fontFamily: "TurretRoad",
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
      home: NotePage(),
      initialRoute: NotePage.routeName,
      routes: {
        NoteList.routeName: (ctx) => NotePage(),
        EditNote.routeName: (ctx) => EditNote(),
      },
    );
  }
}

class NotePage extends StatefulWidget {
  static const String routeName = "/";
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<NoteModel> _noteList = [];

  /// Function {__addNote} : Adds A New Note
  void _addNote(String itemTitle, String itemDescription, DateTime itemDate) {
    setState(
      () {
        _noteList.add(
          NoteModel(
            title: itemTitle,
            description: itemDescription,
            transaction_date: itemDate,
            id: itemDate.toString(),
          ),
        );
      },
    );
  }

  /// Function {_deleteNote} : Deletes A  Note
  void _delete_Note(String id) {
    setState(
      () {
        _noteList.removeWhere(
          (trans) {
            return trans.id == id;
          },
        );
      },
    );
  }

  /// Model Bottom Sheet
  void _showModel() {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return AddNote(
          addNote: _addNote,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Taker"),
        centerTitle: true,
      ),
      body: NoteList(
        noteList: _noteList,
        deleteNote: _delete_Note,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModel,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
