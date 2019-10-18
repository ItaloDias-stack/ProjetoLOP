class Turma{
  final String nome_turma,cod,id_turma,id_prof;

  Turma(this.nome_turma,this.cod,this.id_turma,this.id_prof);

  String get getNomeTurma {
    return nome_turma;
  }

  String get getIdTurma {
    return id_turma;
  }

  String get getIdProf {
    return id_prof;
  }

  String get getCod {
    return cod;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Nome da Turma:"+nome_turma+" Codigo: "+cod;
  }
}