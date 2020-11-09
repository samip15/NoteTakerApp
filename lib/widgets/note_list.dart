import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_taker_app/model/note_model.dart';

class NoteList extends StatelessWidget {
  List<NoteModel> noteList;
  final Function deleteNote;

  NoteList({@required this.noteList, @required this.deleteNote});

  @override
  Widget build(BuildContext context) {
    ThemeData _themeConst = Theme.of(context);
    return noteList.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "No Notes have been added!",
                      style: _themeConst.textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Image.asset(
                    "assets/images/nonote.png",
                    height: constraints.maxHeight * 0.6,
                    fit: BoxFit.cover,
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (iCtx, index) {
              return Dismissible(
                key: ValueKey(noteList[index].id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: const EdgeInsets.only(right: 20),
                ),
                onDismissed: (direction) {
                  deleteNote(noteList[index].id);
                },
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: Container(
                        width: 50,
                        child: FittedBox(
                          child: Text(
                            "${noteList[index].title}",
                            style: _themeConst.textTheme.subtitle2.copyWith(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      title: Text(
                        noteList[index].description,
                        style: _themeConst.textTheme.headline6
                            .copyWith(fontSize: 21),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMEd()
                            .format(noteList[index].transaction_date),
                        style: _themeConst.textTheme.caption
                            .copyWith(fontSize: 11),
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
