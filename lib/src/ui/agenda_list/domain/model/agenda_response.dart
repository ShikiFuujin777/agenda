import 'agenda_model.dart';

class AgendaResponse {
  final List<AgendaModel> dataList;
  final bool hasMoreRecords;

  AgendaResponse({
    required this.dataList,
    required this.hasMoreRecords,
  });
}
