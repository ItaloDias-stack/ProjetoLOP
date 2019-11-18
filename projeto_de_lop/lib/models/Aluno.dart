
class Aluno{
  final String nome,matricula,codigo;
  final String id;
  Aluno(this.nome,this.matricula,this.codigo,this.id);

  String get getNome{
    return nome;
  }

  String get getMatricula{
    return matricula;
  }

  String get getCodigo{
    return codigo;
  }

  String get getId{
    return id;
  }
}