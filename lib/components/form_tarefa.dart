import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormTarefa extends StatefulWidget {
  Function(String, DateTime,String,String,String) onSubmit;
  FormTarefa(this.onSubmit);

  @override
  State<FormTarefa> createState() => _FormTarefaState();
}

class _FormTarefaState extends State<FormTarefa> {

  final _tarefaController = TextEditingController();
  final _descricaoController = TextEditingController();
  String _prioridade = 'BAIXA';
  final _observacaoController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  @override
  Widget build(BuildContext context) {

    _submitForm() {
      // final titulo = _tarefaController.text;
      if (_tarefaController.text.isEmpty) {
        return;
      }
      //passando dado para componente pai
      widget.onSubmit(_tarefaController.text, _dataSelecionada,_descricaoController.text, _prioridade,_observacaoController.text); // Use _prioridade instead of _prioridadeController.text
    }

    _showDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024),
              lastDate: DateTime(2025))
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _dataSelecionada = pickedDate;
        });
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        children: [
          TextField(
            controller: _tarefaController,
            decoration: const InputDecoration(labelText: 'nova tarefa...'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'descrição...'),
          ),
          
          TextField(
            controller: _observacaoController,
            decoration: const InputDecoration(labelText: 'observações...'),
          ),
          DropdownButtonFormField<String>(
            value: _prioridade,
            items: [
              DropdownMenuItem(
                value: 'ALTA',
                child: Text('ALTA'),
              ),
              DropdownMenuItem(
                value: 'MEDIA',
                child: Text('MEDIA'),
              ),
              DropdownMenuItem(
                value: 'BAIXA',
                child: Text('BAIXA'),
              ),
            ],
            onChanged: (value) {
              if(value == null) return;
              setState(() {
                _prioridade = value;
              });
            },
            decoration: const InputDecoration(labelText: 'prioridade...'),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      'Data selecionada ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}'),
                ),
                TextButton(
                    onPressed: _showDatePicker, child: Text('Selecionar data'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: _submitForm, child: Text('Cadastrar tarefa')),
          )
        ],
      ),
    );
  }
}
