import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late final List<TaskModel> list;

  @override
  void initState() {
    super.initState();
    list = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.abc_rounded),
                      Text(list[position].name)
                    ],
                  ),
                  LinearProgressIndicator(
                    value: list[position].progress * 0.01,
                  ),
                ],
              ),
            );
          },
          itemCount: list.length,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: add,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: remove,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  void add() async {
    var item = TaskModel(name: Random.secure().nextInt(1000).toString());
    if (list.isEmpty) {
      list.add(item);
    } else {
      list.insert(0, item);
    }
    setState(() {});

    while (item.progress < 100) {
      await Future.delayed(const Duration(milliseconds: 500));
      item.progress += 10;
      setState(() {});
    }

    item.progress = 100;
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 1000));
  }

  void remove() {
    list.removeAt(0);
    setState(() {});
  }
}

class TaskModel {
  TaskModel({required this.name});

  String name;
  int progress = 0;
}
