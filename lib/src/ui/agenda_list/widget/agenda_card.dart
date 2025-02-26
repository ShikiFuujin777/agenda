import 'package:agenda/src/commons/util/date_format_utils.dart';
import 'package:agenda/src/ui/agenda_list/domain/model/agenda_model.dart';
import 'package:flutter/material.dart';

class AgendaCard extends StatelessWidget {
  final AgendaModel model;
  final ValueChanged<AgendaModel> onPressed;

  const AgendaCard({
    super.key,
    required this.model,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final date = model.date;

    final timeFormatted = date.format(context, 'HH:mm a');
    final dateFormatted = date.format(context, 'dd MMMM yyyy');

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            timeFormatted,
            style: TextStyle(fontSize: 32),
          ),
          Text(dateFormatted),
          const SizedBox(height: 8,),
          Text(model.text),
        ],
      ),
    );
  }
}
