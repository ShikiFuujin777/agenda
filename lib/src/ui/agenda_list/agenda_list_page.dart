import 'package:agenda/src/commons/util/array_utils.dart';
import 'package:agenda/src/ui/agenda_list/domain/config/agenda_list_config.dart';
import 'package:agenda/src/ui/agenda_list/domain/model/agenda_model.dart';
import 'package:agenda/src/ui/agenda_list/domain/notifier/agenda_list_notifier.dart';
import 'package:agenda/src/ui/agenda_list/presenter/agenda_list_presenter.dart';
import 'package:agenda/src/ui/agenda_list/widget/agenda_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'args/agenda_list_args.dart';
import 'presenter/page/agenda_list_interface.dart';

class AgendaList extends StatefulWidget {
  final AgendaListArgs args;

  const AgendaList({
    super.key,
    required this.args,
  });

  @override
  State<AgendaList> createState() => _AgendaListState();
}

class _AgendaListState extends State<AgendaList>
    implements AgendaListInterface {
  late AgendaListNotifier notifier;
  late AgendaListPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => notifier,
      builder: (_, child) {
        print('BUILD');
        final notifier = _.watch<AgendaListNotifier>();

        final isInitState = notifier.isInitState;
        final isLoadingState = notifier.isLoadingState;
        final hasMoreRecords = notifier.hasMoreRecords;
        final dataList = notifier.dataList;

        final showMoreRecordsButton =
            hasMoreRecords && !isLoadingState && dataList.isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Nueva'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isInitState
                        ? Text('Pantalla inicial de la agenda')
                        : Column(
                            children: [
                              if (dataList.isNotEmpty)
                                ...dataList.builder<Widget>(
                                  itemBuilder: (index, item) => AgendaCard(
                                    model: item,
                                    onPressed: _onItemPressed,
                                  ),
                                  addedItemBuilder: (index) => const SizedBox(
                                    height: 8,
                                  ),
                                ),
                              if (dataList.isEmpty) Text('No hay lista'),
                              if (isLoadingState) Text('Cargando ...'),
                              if (showMoreRecordsButton)
                                ElevatedButton(
                                  onPressed: _fetchData,
                                  child: Text('Cargar mas datos'),
                                ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  void _fetchData() {
    presenter.fetchData();
  }

  void _onItemPressed(AgendaModel agendaModel) {}

  @override
  void initState() {
    notifier = AgendaListNotifier();
    presenter = AgendaListPresenter(
      page: this,
      config: widget.args.config,
      notifier: notifier,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      _fetchData();
    });
    super.initState();
  }
}
