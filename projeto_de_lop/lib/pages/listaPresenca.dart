import 'package:flutter/material.dart';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:projeto_de_lop/models/Presenca.dart';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:projeto_de_lop/models/Turma.dart';
import 'package:projeto_de_lop/pages/detalhes.dart';
import 'package:projeto_de_lop/pages/inicio.dart';

import 'editarTurma.dart';

class ListaPresenca extends StatefulWidget {
  final Turma turma;
  const ListaPresenca({Key key, this.turma}) : super(key: key);
  @override
  _ListaPresencaState createState() => _ListaPresencaState(turma: this.turma);
}

class _ListaPresencaState extends State<ListaPresenca> {
  Turma turma;
  _ListaPresencaState({this.turma});
  @override
  Widget build(BuildContext context) {
    final deleteTurma = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(32),
      color: Colors.deepOrangeAccent,
      child: MaterialButton(
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {},
        child: Text('Deletar Truma',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
      ),
    );

    final editTurma = Material(
        elevation: 5,
        color: Color(0xff01A0C7),
        borderRadius: BorderRadius.circular(32),
        child: MaterialButton(
          minWidth: 100,
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarTurma(turma: turma)));
          },
          child: Text(
            'Editar Turma',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ));

    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          Text("Turma de " + turma.getNomeTurma,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: SizedBox(
              height: 50,
              child: new FutureBuilder(
                future: chamadaList(turma),
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
                            title: Text(snapshot.data[i].dia),
                            onTap: () async {
                              Presenca presenca = new Presenca(
                                  snapshot.data[i].id_chamada,
                                  snapshot.data[i].id_turma,
                                  snapshot.data[i].dia,
                                  snapshot.data[i].id_aluno);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detalhes(presenca: presenca)));
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
            child: Wrap(
              spacing: 50,
              children: <Widget>[deleteTurma, editTurma],
            ),
          ),
        ],
      ),
    ));
  }
}
