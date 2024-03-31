import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/form_tarefa.dart';
import 'components/lista_tarefa.dart';
import 'model/tarefa.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.purple,
                secondary: Colors.amber,
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tarefa> _tarefas = [
    // Tarefa(id:'t0',titulo:'titulo',data: DateTime.now(), descricao:'descricao' ,prioridade:'prioridade', observacao:'observacao'),
  ];

  _novaTarefa(String tarefa, DateTime data, String descricao, String prioridade,
      String observacao) {
    Tarefa novaTarefa = Tarefa(
        id: Random().nextInt(9999).toString(),
        titulo: tarefa,
        data: data,
        descricao: descricao,
        prioridade: prioridade,
        observacao: observacao);

    setState(() {
      _tarefas.add(novaTarefa);
    });

    Navigator.of(context).pop();
  }

  //Modal
  _openTaskFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return FormTarefa(_novaTarefa);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        actions: [
          IconButton(
              onPressed: () => SystemSound.play(SystemSoundType.click),
              icon: Icon(Icons.arrow_upward))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // formulario de tarefa

            //FormTarefa(_novaTarefa),
            const SizedBox(
              height: 20,
            ),
            // lista de tarefas
            ListaTarefa(listaTarefas: _tarefas),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
