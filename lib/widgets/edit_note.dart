import 'package:flutter/material.dart';
import 'package:note_taker_app/model/note_model.dart';
import 'package:provider/provider.dart';

class EditNote extends StatefulWidget {
  static const String routeName = "/edit_note";
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  ThemeData themeConst;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String _id;
  String _description, _title;
  DateTime _transaction_date;
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      await _addOrUpdateNotes();
    }
  }

  Future<void> _addOrUpdateNotes() async {
    final newNotes = NoteModel(
        id: DateTime.now().toString(),
        description: _description,
        transaction_date: _transaction_date,
        title: _title);
    try {
      if (_id.isNotEmpty && _id != null) {
        await Provider.of<NoteModel>(context, listen: false)
            .updateNote(_id, newNotes);
      } else {
        await Provider.of<NoteModel>(context, listen: false).addNotes(newNotes);
      }
      Navigator.pop(context);
    } catch (error) {
      _scafoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Something Went Wrong! please try again"),
        backgroundColor: themeConst.errorColor,
      ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String titleText = titleController.value.text;
    final String descriptionText = descriptionController.value.text;
    themeConst = Theme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit Text"),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                _saveForm();
              },
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: titleController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSubmitted: (value) {
                  _title = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(50),
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  _description = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bool init = true;
    NoteModel model = ModalRoute.of(context).settings.arguments;
    String titleEdit = model.title;
    String descriptionEdit = model.description;
    if (init) {
      titleController.text = titleEdit;
      descriptionController.text = descriptionEdit;
    }
    init = false;
  }
}
