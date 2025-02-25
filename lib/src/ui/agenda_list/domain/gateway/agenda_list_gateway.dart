import 'package:agenda/src/commons/exceptions/model/business_error.dart';

import '../model/agenda_response.dart';

abstract class AgendaListGateway {
  Future<(BusinessError?, AgendaResponse)> getList({
    required int pageNumber,
    required int itemsNumber,
  });
}
