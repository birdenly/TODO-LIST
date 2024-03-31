class Tarefa {
  String id;
  String titulo;
  DateTime data;
  
  String descricao;
  String prioridade;
  String observacao;
  DateTime dataCriacao;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.data,
    required this.descricao,
    required this.prioridade,
    required this.observacao,
  }) : dataCriacao = DateTime.now();
}
