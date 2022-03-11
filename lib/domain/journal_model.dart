class Journal {
  final String id;
  final String title;
  final String body;
  final DateTime date;

  const Journal({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  //this function helps in updating the journal entry
  Journal copyWith({String? id, String? title, String? body, DateTime? date}) =>
      Journal(
          id: id ?? this.id,
          title: title ?? this.title,
          body: body ?? this.body,
          date: date ?? this.date);
}
