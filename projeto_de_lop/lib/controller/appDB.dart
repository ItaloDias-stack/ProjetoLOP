import 'dart:convert';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_de_lop/models/Turma.dart';

String url = "http://192.168.0.18/projeto/";
Professor professor = new Professor("", "", "", "");
Future<Professor> login(String usuario, String senha) async {
  final response = await http
      .post(url + "login.php", body: {"usuario": usuario, "senha": senha});

  print(response.body);

  if (response.body.length > 2) {
    //Aq ele realizou o login cm sucesso
    var datauser = json.decode(response.body);
    Professor professors = new Professor(datauser["nome"], datauser["usuario"],
        datauser["senha"], datauser["id_prof"] + "");
    professor = professors;
    return professor;
  }
  return professor;
}

Future<bool> createAcc(String nome, String usuario, String senha) async {
  final response = await http.post(url + "adddata.php",
      body: {"nome": nome, "usuario": usuario, "senha": senha});
  print(response.body);
  var datauser = json.decode(response.body);
  print(datauser["message"].toString());
  if (datauser["message"] == "true") {
    return true;
  } else {
    return false;
  }
}

Future<bool> createTurma(String cod, String nome_turma, Professor prof) async {
  final response = await http.post(url + "createTurma.php",
      body: {"cod": cod, "nome_turma": nome_turma, "id_prof": prof.getId});
  var datauser = json.decode(response.body);
  print(datauser["message"].toString());
  if (datauser["message"] == "true") {
    return true;
  } else {
    return false;
  }
}

Future<List<Turma>> listarTurmas(Professor prof)async {
  final response =
      await http.post(url + "getTurma.php", body: {"id_prof": prof.getId});
  var datauser = json.decode(response.body);
  List<Turma> listTurma = [];
  for (var i in datauser) {
    Turma turma = new Turma(i["nome_turma"],i["cod"],i["id_turma"],i["id_prof"]);
    print(turma);
    listTurma.add(turma);

  }
  return listTurma;
}
