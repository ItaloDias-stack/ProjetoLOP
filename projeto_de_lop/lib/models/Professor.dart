class Professor {
  final String nome, usuario, senha,id_prof;
  Professor(this.nome, this.usuario, this.senha,this.id_prof);
  String get getNome {
    return nome;
  }

  String get getSenha {
    return senha;
  }

  String get getUsuario {
    return usuario;
  }

  String get getId{
    return id_prof;
  }
  @override
  String toString() {
    return "Nome: " + nome + " Usuário: " + usuario + " Senha: " + senha;
  }
}
