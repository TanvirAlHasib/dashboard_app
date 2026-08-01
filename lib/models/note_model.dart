class NoteModel {
  NoteModel({required this.title, required this.description, this.category = ""});

  final String category;
  final DateTime ? dateTime = null;
  final String title;
  final String description;

  String get Title =>  title;
  String get Description =>  description;
  String get Category =>  category;
  DateTime get Datetime => dateTime!;

}