// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f02_todo_list/components/detalhes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import '../model/tarefa.dart';

class ListaTarefa extends StatefulWidget {
  List<Tarefa> listaTarefas;

  ListaTarefa({
    required this.listaTarefas,
  });

  @override
  _ListaTarefaState createState() => _ListaTarefaState();
}

class _ListaTarefaState extends State<ListaTarefa> {
  var retorno;
  int tipo = 0;
  List<Tarefa> inicial = [];
  comparacoes() {
    inicial = List.from(widget.listaTarefas);
    int tipoL;
    if (tipo == 0) {
      tipoL = 1;
    } else if (tipo == 1) {
      tipoL = 2;
    } else {
      tipoL = 3;
    }

    tipoL == 1
        ? widget.listaTarefas.sort((a, b) {
            if (a.prioridade == 'ALTA') {
              return -1;
            } else if (b.prioridade == 'ALTA') {
              return 1;
            } else if (a.prioridade == 'MEDIA') {
              return -1;
            } else if (b.prioridade == 'MEDIA') {
              return 1;
            } else {
              return 0;
            }
          })
        : tipoL == 2
            ? widget.listaTarefas.sort((a, b) {
                if (a.data.isBefore(b.data)) {
                  return -1;
                } else if (b.data.isBefore(a.data)) {
                  return 1;
                } else {
                  return 0;
                }
              })
            : tipoL == 3
                ? widget.listaTarefas.sort((a, b) {
                    if (a.dataCriacao.isBefore(b.dataCriacao)) {
                      return -1;
                    } else if (b.dataCriacao.isBefore(a.dataCriacao)) {
                      return 1;
                    } else {
                      return 0;
                    }
                  })
                : widget.listaTarefas = inicial;
    setState(() {
      tipo = tipoL;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.listaTarefas.length == 0
        ? retorno =
            Text("Nenhuma tarefa cadastrada!", style: TextStyle(fontSize: 20))
        : retorno = Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: PopupMenuButton<String>(
                  onSelected: (String result) {
                    setState(() {
                      tipo = int.parse(result);
                      comparacoes();
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: '0',
                      child: Text('Ordenar por prioridade'),
                    ),
                    const PopupMenuItem<String>(
                      value: '1',
                      child: Text('ordenar por data de execução'),
                    ),
                    const PopupMenuItem<String>(
                      value: '2',
                      child: Text('order por data de criação'),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.listaTarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = widget.listaTarefas[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              tarefa: tarefa,
                              listaTarefas: widget.listaTarefas,
                              index: index,
                              update: comparacoes,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color:
                                          tarefa.data.isBefore(DateTime.now())
                                              ? Colors.red
                                              : Colors.orange),
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text(
                                        DateFormat('d MMM y')
                                            .format(tarefa.data),
                                        style: TextStyle(
                                            color: tarefa.data
                                                    .isBefore(DateTime.now())
                                                ? Colors.red
                                                : Colors.orange))
                                  ],
                                )),
                            Text(tarefa.titulo,
                                style: TextStyle(
                                    color: tarefa.data.isBefore(DateTime.now())
                                        ? Colors.red
                                        : Colors.orange)),
                            SizedBox(
                              width: 10,
                            ),
                            Text('|'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(tarefa.prioridade,
                                style: TextStyle(
                                    color: tarefa.prioridade == 'ALTA'
                                        ? Colors.red
                                        : tarefa.prioridade == 'MEDIA'
                                            ? Colors.orange
                                            : Colors.blue)),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
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
                                              widget.listaTarefas
                                                  .removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );

    return retorno;
  }
}
