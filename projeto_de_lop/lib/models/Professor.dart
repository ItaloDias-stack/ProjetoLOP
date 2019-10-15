class Professor {
   final String nome, usuario, senha;

  Professor(this.nome,this.usuario,this.senha);
  String get getNome{
    return nome;
  }

  String get getSenha{
    return senha;
  }

  String get getUsuario{
    return usuario;
  }
  @override
  String toString() {
    return "Nome: "+nome+" Usuário: "+usuario+" Senha: "+senha;
  }
}
