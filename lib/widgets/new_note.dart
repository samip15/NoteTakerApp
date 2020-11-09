import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  final Function addNote;
  AddNote({@required this.addNote});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDateTime;
  void addNote() {
    final String titleText = _titleController.value.text;
    final String descriptionText = _descriptionController.value.text;
    if (titleText.isEmpty ||
        descriptionText.isEmpty ||
        _selectedDateTime == null) {
      return;
    } else {
      widget.addNote(titleText, descriptionText, _selectedDateTime);
    }
    Navigator.pop(context);
  }

  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickDate) {
      setState(() {
        _selectedDateTime = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeConst = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: mediaQuery.viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note_add),
                labelText: "Title Note",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.text,
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.description),
                labelText: "Note Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.multiline,
              controller: _descriptionController,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => addNote(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDateTime == null
                      ? "No Date Entered"
                      : "Picked Date: ${DateFormat.yMd().format(_selectedDateTime)}",
                  style: TextStyle(fontSize: 10),
                ),
                FlatButton(
                  onPressed: pickDate,
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Choose a Date",
                    style: _themeConst.textTheme.headline6.copyWith(
                        fontSize: 15, color: _themeConst.primaryColor),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: addNote,
              child: Text("Add Note"),
              color: _themeConst.accentColor,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
