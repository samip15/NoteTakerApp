import 'package:flutter/foundation.dart';

class NoteModel {
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
}
