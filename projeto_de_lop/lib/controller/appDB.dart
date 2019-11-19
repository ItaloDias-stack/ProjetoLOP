import 'dart:convert';
import 'package:projeto_de_lop/models/Aluno.dart';
import 'package:projeto_de_lop/models/Presenca.dart';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_de_lop/models/Turma.dart';

String url =
    "http://192.168.0.18/projeto/"; // Lembrar de trocar o ip para o la de casa dps
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

Future<List<Turma>> listarTurmas(Professor prof) async {
  final response =
      await http.post(url + "getTurma.php", body: {"id_prof": prof.getId});
  var datauser = json.decode(response.body);
  List<Turma> listTurma = [];
  for (var i in datauser) {
    Turma turma =
        new Turma(i["nome_turma"], i["cod"], i["id_turma"], i["id_prof"]);
    print(turma);
    listTurma.add(turma);
  }
  return listTurma;
}

Future<List<Aluno>> listarPresenca(Presenca presenca) async {
  final response = await http
      .post(url + "getPresenca.php", body: {"id_turma": presenca.getIdTurma});
  var datauser = json.decode(response.body);
  List<Aluno> listAluno = [];
  for (var i in datauser) {
    Aluno aluno = new Aluno(i['nome'], i['matricula'], i['codigo'], i['id']);
    print(datauser);
    listAluno.add(aluno);
  }
  return listAluno;
}

Future<List<Presenca>> chamadaList(Turma turma) async {
  final response = await http
      .post(url + "getListaChamada.php", body: {"id_turma": turma.getIdTurma});
  var datauser = json.decode(response.body);
  List<Presenca> listPresenca = [];
  for (var i in datauser) {
    Presenca presenca =
        new Presenca(i["id_chamada"], i["id_turma"], i["dia"], i["id_aluno"]);
    print(turma);
    listPresenca.add(presenca);
  }
  return listPresenca;
}

Future<Turma> getTurmaById(Presenca presenca) async {
  final response = await http
      .post(url + "getTurmaById.php", body: {"id_turma": presenca.getIdTurma});
  var datauser = json.decode(response.body);
  print(datauser);
  Turma turma = new Turma(datauser["nome_turma"] + "", datauser["cod"] + "",
      datauser["id_turma"] + "", datauser["id_prof"] + "");
  return turma;
}

Future<bool> updateTurma(String nome, String cod, String id_turma) async {
  final response = await http.post(url + "updateTurma.php",
      body: {"id_turma": id_turma, "nome_turma": nome, "cod": cod});
  var datauser = json.decode(response.body);
  print(datauser);
  if (datauser["message"] == "true") {
    return true;
  } else {
    return false;
  }
}

Future<Professor> getProfessorById(Turma turma) async {
  final response = await http
      .post(url + "getProfessorById.php", body: {"id_prof": turma.id_prof});
  var datauser = json.decode(response.body);
  Professor professor = new Professor(datauser["nome"], datauser["usuario"],
      datauser["senha"], datauser["id_prof"]);
  return professor;
}

Future<bool> inserirAlunos(Aluno aluno, Turma turma) async {
  final response = await http.post(url + "addAluno.php", body: {
    "nome": aluno.getNome,
    "codigo": aluno.getCodigo,
    "matricula": aluno.getMatricula
  });
  print(response.body);
  var i = json.decode(response.body);
  if(i["message"] == "true"){
    print('entrei');
    await inserirAlunoTurma(await getAluno(aluno.getNome,aluno.getMatricula), turma);
    return true;
  }else{
    return false;
  }
}

Future<Aluno> getAluno(String nome,String matricula) async {
  final response = await http.post(url + "getAlunoByNome.php",
      body: {"nome": nome, "matricula": matricula});
  var i = json.decode(response.body);
  print(response.body);
  Aluno aluno2 = new Aluno(i['nome'], i['matricula'], i['codigo'], i['id_aluno']);
  print("Aluno id: "+aluno2.getId);
  return aluno2;
}

void inserirAlunoTurma(Aluno aluno, Turma turma) async {
  print("Id aluno: "+aluno.getId+",id turma: "+turma.getIdTurma);
  final response = await http.post(url + "addAlunoTurma.php",
      body: {"id_aluno": aluno.getId, "id_turma": turma.getIdTurma});
}

void deleteTurma(Turma turma) async {
  final response = await http
      .post(url + "getAlunoById.php", body: {"id_turma": turma.getIdTurma});
  var r = json.decode(response.body);
  print("Tamanho: "+response.body.length.toString());
  print(r.toString());
  if (response.body.length > 2) {
    Aluno aluno = new Aluno(r['nome'], r['matricula'], r['codigo'], r['id_aluno']);
    final response2 = await http.post(url + "deleteTurma.php",
        body: {"id_turma": turma.getIdTurma, "id_aluno": aluno.getId});
  } else {
    final response3 = await http.post(url + "deleteTurmaSemAluno.php",
        body: {"id_turma": turma.getIdTurma});
  }
}
