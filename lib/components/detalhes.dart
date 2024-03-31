import 'package:f02_todo_list/model/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  Tarefa tarefa;
  List<Tarefa> listaTarefas;
  int index;
  final Function update;

  DetailPage({
    required this.tarefa,
    required this.listaTarefas,
    required this.index,
    required this.update,
  });

  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Tarefa:'),
        actions: [
          IconButton(
              onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Realmente deseja excluir?'),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Excluir'),
                              onPressed: () {
                                setState(() {
                                  widget.listaTarefas.removeAt(widget.index);
                                });
                                widget.update();
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                            ),
                          ],
                        );
                      },
                    )
                  },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Editar Tarefa'),
                            content: Column(
                              children: [
                                TextField(
                                  controller: TextEditingController(
                                      text: widget.tarefa.titulo),
                                  decoration: const InputDecoration(
                                      labelText: 'nova tarefa...'),
                                  onChanged: (value) {
                                    widget.tarefa.titulo = value;
                                  },
                                ),
                                TextField(
                                  controller: TextEditingController(
                                      text: widget.tarefa.descricao),
                                  decoration: const InputDecoration(
                                      labelText: 'descrição...'),
                                  onChanged: (value) {
                                    widget.tarefa.descricao = value;
                                  },
                                ),
                                TextField(
                                  controller: TextEditingController(
                                      text: widget.tarefa.observacao),
                                  decoration: const InputDecoration(
                                      labelText: 'observação...'),
                                  onChanged: (value) {
                                    widget.tarefa.observacao = value;
                                  },
                                ),
                                DropdownButton<String>(
                                  value: widget.tarefa.prioridade,
                                  items: <String>['BAIXA', 'MÉDIA', 'ALTA']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      widget.tarefa.prioridade = value!;
                                    });
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: widget.tarefa.data,
                                            firstDate: DateTime(2024),
                                            lastDate: DateTime(2025))
                                        .then((pickedDate) {
                                      if (pickedDate == null) {
                                        return;
                                      }
                                      setState(() {
                                        widget.tarefa.data = pickedDate;
                                      });
                                    });
                                  },
                                  child: Text('Data: ' +
                                      DateFormat('d MMM y')
                                          .format(widget.tarefa.data)),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Salvar'),
                                onPressed: () {
                                  setState(() {
                                    widget.update();
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        })
                  },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Tarefa: ${widget.tarefa.titulo}'),
                  Text('Data: ' +
                      DateFormat('d MMM y').format(widget.tarefa.data)),
                  Text('Descrição: ${widget.tarefa.descricao}'),
                  Text('Prioridade: ${widget.tarefa.prioridade}'),
                  Text('Observação: ${widget.tarefa.observacao}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
