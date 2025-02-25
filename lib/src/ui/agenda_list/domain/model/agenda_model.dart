class AgendaModel {
  final String code;
  final String text;
  final DateTime date;
  final AgendaState state;

  AgendaModel({
    required this.code,
    required this.text,
    required this.date,
    required this.state,
  });
}

enum AgendaState {
  registered,
  confirmed,
  running,
  finished,
  postponed,
  canceled,
}
