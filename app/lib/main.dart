import 'package:app/counter_repository.dart';
import 'package:counter_edge_functions/model/counter_response.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CounterRepository();
    return MaterialApp(
      title: 'Edge Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Fetch the initial count from the Edge Function.
      home: FutureBuilder<CounterResponse>(
        future: repository.count,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox();
          }
          return MyHomePage(
            title: 'Edge Counter',
            initialCount: snapshot.data?.count ?? 0,
            onIncrement: repository.increment,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.initialCount,
    required this.onIncrement,
  });

  final String title;
  final int initialCount;
  final Future<CounterResponse> Function() onIncrement;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter;

  // Increment through the Edge Function, and update with the latest count.
  Future<void> _incrementCounter() async {
    final response = await widget.onIncrement();
    setState(() {
      _counter = response.count;
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Users have pushed the button this many times:',
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
      ),
    );
  }
}
