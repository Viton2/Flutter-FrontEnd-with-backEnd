class Exercicio {
  final String nome;
  final String descricao;
  final int repeticao;
  final int caloria;

  Exercicio(this.nome, this.descricao, this.repeticao, this.caloria);

  @override
  String toString() {
    return 'Exercicio{nome: $nome, descricao: $descricao, repeticao: $repeticao, caloria: $caloria}';
  }
}
