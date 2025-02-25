import 'package:agenda/src/commons/exceptions/model/business_error.dart';
import 'package:agenda/src/ui/agenda_list/domain/gateway/agenda_list_gateway.dart';
import 'package:agenda/src/ui/agenda_list/domain/model/agenda_model.dart';
import 'package:flutter/material.dart';

import '../../ui/agenda_list/domain/model/agenda_response.dart';

class AgendaListApi implements AgendaListGateway {
  final BuildContext context;

  AgendaListApi(this.context);

  @override
  Future<(BusinessError?, AgendaResponse)> getList({
    required int pageNumber,
    required int itemsNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 3));

    print('HACE LA CARGA pageNumber: $pageNumber, itemsNumber: $itemsNumber');
    return (
      null,
      AgendaResponse(
        dataList: List.generate(
          itemsNumber,
          (index) => AgendaModel(
            code: '00$index',
            text: 'Nueva cita $index | Pagina $pageNumber',
            state: AgendaState.registered,
            date: DateTime.now(),
          ),
        ),
        hasMoreRecords: true,
      ),
    );
  }
}
