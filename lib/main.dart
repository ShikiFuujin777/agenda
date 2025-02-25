import 'package:agenda/src/ui/agenda_list/agenda_list_page.dart';
import 'package:agenda/src/ui/agenda_list/args/agenda_list_args.dart';
import 'package:agenda/src/ui/agenda_list/domain/config/agenda_list_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/repository/infra.dart';
import 'src/ui/agenda_list/domain/gateway/agenda_list_gateway.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AgendaListGateway>(
          create: (_) => AgendaListApi(_),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/agenda-list',
        routes: {
          '/': (_) => const MyHomePage(title: 'Flutter Demo Home Page'),
          '/agenda-list': (_) => AgendaList(
                args: AgendaListArgs(
                  config: AgendaListConfig(
                    gateway: _.read<AgendaListGateway>(),
                  ),
                ),
              ),
        },
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child ?? const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
