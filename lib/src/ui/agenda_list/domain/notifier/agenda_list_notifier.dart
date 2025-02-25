import 'package:agenda/src/ui/agenda_list/domain/model/agenda_response.dart';
import 'package:flutter/material.dart';

import '../model/agenda_model.dart';

class AgendaListNotifier with ChangeNotifier {
  int _pageNumber = 0;
  int get pageNumber => _pageNumber;

  bool _hasMoreRecords = true;
  bool get hasMoreRecords => _hasMoreRecords;

  final List<AgendaModel> _dataList = [];
  List<AgendaModel> get dataList => _dataList;

  void setDataResponse(AgendaResponse agendaResponse) {
    _dataList.addAll(agendaResponse.dataList);
    _hasMoreRecords =
        _dataList.isNotEmpty ? agendaResponse.hasMoreRecords : false;

    setLoadedState();
  }

  FetchState _fetchState = FetchState.initial;
  FetchState get fetchState => _fetchState;

  bool get isInitState => _fetchState == FetchState.initial;
  bool get isLoadingState => _fetchState == FetchState.loading;

  void initLoad() {
    if (!canFetch) return;

    _pageNumber++;
    _fetchState = FetchState.loading;
    notifyListeners();
  }

  void setLoadedState() {
    _fetchState = FetchState.loaded;
    notifyListeners();
  }

  bool get canFetch {
    /// Si está ya cargando, NO PUEDE hacer la carga.
    if (isLoadingState) return false;

    /// Si está en estado inicial, PUEDE hacer la carga.
    if (_fetchState == FetchState.initial) return true;

    /// Sí ya no tiene mas registros por carga, NO PUEDE hacer la carga.
    if (!_hasMoreRecords) return false;

    /// Ya por defecto, debería poder hacer la carga.
    return true;
  }
}

enum FetchState {
  initial,
  loading,
  loaded,
}
