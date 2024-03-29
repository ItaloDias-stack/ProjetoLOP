import 'package:flutter/material.dart';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:projeto_de_lop/models/Turma.dart';
import 'package:projeto_de_lop/pages/criarTurma.dart';
import 'package:projeto_de_lop/pages/detalhes.dart';
import 'package:projeto_de_lop/pages/listaPresenca.dart';

class Inicio extends StatefulWidget {
  final Professor prof;
  const Inicio({Key key, this.prof}) : super(key: key);
  @override
  _InicioState createState() => _InicioState(prof: this.prof);
}

class _InicioState extends State<Inicio> {
  Professor prof;
  _InicioState({this.prof});
  @override
  Widget build(BuildContext context) {
    final createTurma = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(32),
        color: Colors.deepOrangeAccent,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 1.2,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CriarTurma(prof: prof)));
          },
          child: Text('Criar Turma',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ));

    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          Text("Minhas turmas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: SizedBox(
              height: 50,
              child: new FutureBuilder(
                future: listarTurmas(prof),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Carregando ..."),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                            title: Text(snapshot.data[i].nome_turma),
                            subtitle: Text("Código: " + snapshot.data[i].cod),
                            onTap: () {
                              Turma turma = new Turma(
                                  snapshot.data[i].nome_turma,
                                  snapshot.data[i].cod,
                                  snapshot.data[i].id_turma,
                                  snapshot.data[i].id_prof);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListaPresenca(turma: turma)));
                            },
                            leading: CircleAvatar(
                              backgroundColor: Color(0xff01A0C7),
                              foregroundColor: Colors.white,
                              child: Text('${i + 1}'),
                            ));
                      },
                    );
                  }
                },
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: createTurma,
          ),
        ],
      ),
    ));
  }
}
