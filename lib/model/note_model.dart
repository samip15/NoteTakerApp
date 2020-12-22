import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:note_taker_app/model/Api.dart';

class NoteModel with ChangeNotifier {
  String title;
  String description;
  DateTime transaction_date;
  String id;

  NoteModel({
    @required this.title,
    @required this.description,
    @required this.transaction_date,
    @required this.id,
  });

// fetch all Notes from firebase
  Future<List<NoteModel>> fetchAllNotes() async {
    try {
      final response = await http.get(API.notes);
      final allMap = json.decode(response.body) as Map<String, dynamic>;
      final List<NoteModel> allNotes = [];
      allMap.forEach((noteId, noteData) {
        allNotes.add(
          NoteModel(
            id: noteId,
            title: noteData['title'],
            description: noteData['description'],
            transaction_date: noteData['transaction_date'],
          ),
        );
      });
      _notes = allNotes;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  List<NoteModel> _notes = [];

// add note
  Future<void> addNotes(NoteModel model) async {
    // add to firebase
    try {
      final response = await http.post(
        API.notes,
        body: json.encode({
          "title": model.title,
          "description": model.description,
          "transaction_date": model.transaction_date,
        }),
      );
      final id = json.decode(response.body);
      final notesModel = NoteModel(
        id: id["name"],
        title: model.title,
        description: model.description,
        transaction_date: model.transaction_date,
      );
      _notes.add(notesModel);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // update note
  Future<void> updateNote(String id, NoteModel updatedNote) async {
    // add to firebase
    try {
      final noteIndex = _notes.indexWhere((note) => note.id == id);
      final response = await http.patch(
        API.baseUrl + "/products/$id.json",
        body: json.encode({
          "title": updatedNote.title,
          "description": updatedNote.description,
          "transaction_date": updatedNote.transaction_date,
        }),
      );
      print(response.body);
      _notes[noteIndex] = updatedNote;
      _notes.add(updatedNote);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
