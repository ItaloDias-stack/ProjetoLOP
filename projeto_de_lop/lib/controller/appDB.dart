import 'dart:convert';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:http/http.dart' as http;

String url = "http://192.168.0.18/projeto/";
Future<Professor> login(String usuario, String senha) async {
  final response = await http.post(url+"login.php",
      body: {"usuario": usuario, "senha": senha});

  print(response.body);
  Professor professor = new Professor("", "", "");
  if (response.body.length > 2) {
    //Aq ele realizou o login cm sucesso
    var datauser = json.decode(response.body);
    Professor professor = new Professor(
      datauser["nome"],
      datauser["usuario"],
      datauser["senha"]);
    return professor;
  }
  return professor;
}

Future<bool> createAcc(String nome, String usuario, String senha) async{
  final response = await http.post(url+"adddata.php",
  body: {"nome": nome, "usuario":usuario, "senha":senha});
  print(response.body);
  var datauser = json.decode(response.body);
  print(datauser["message"].toString());
  if(datauser["message"]=="true"){
    return true;
  }else{
    return false;
  }
}
