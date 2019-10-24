class Presenca {
  final String id_turma, id_chamada, dia;
  final String id_aluno;

  Presenca(this.id_chamada, this.id_turma, this.dia, this.id_aluno);

  String get getIdChamada {
    return id_chamada;
  }

  String get getIdTurma {
    return id_turma;
  }
  String get getDia {
    return dia;
  }

  String get getBlob{
    return id_aluno;
  }
}
