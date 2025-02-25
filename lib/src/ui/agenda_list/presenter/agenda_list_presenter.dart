import 'package:agenda/src/ui/agenda_list/domain/notifier/agenda_list_notifier.dart';

import '../../../commons/exceptions/model/business_error.dart';
import '../domain/config/agenda_list_config.dart';
import '../domain/model/agenda_response.dart';
import 'page/agenda_list_interface.dart';

class AgendaListPresenter {
  final AgendaListInterface page;
  final AgendaListConfig config;
  final AgendaListNotifier notifier;

  AgendaListPresenter({
    required this.page,
    required this.config,
    required this.notifier,
  });

  void fetchData() async {
    final canFetch = notifier.canFetch;
    if (!canFetch) return;

    notifier.initLoad();

    final (BusinessError? error, AgendaResponse response) =
        await config.gateway.getList(
      pageNumber: notifier.pageNumber,
      itemsNumber: 10,
    );

    if (error != null) {
      /// TODO: Por hacer
      print('TENGO ERROR');
      return;
    }

    notifier.setDataResponse(response);
  }
}
