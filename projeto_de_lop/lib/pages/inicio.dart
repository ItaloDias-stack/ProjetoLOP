import 'package:flutter/material.dart';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:projeto_de_lop/models/Turma.dart';
import 'package:projeto_de_lop/pages/criarTurma.dart';
import 'package:flutter/src/rendering/box.dart';

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
    /*final lista = FutureBuilder(
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
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text(snapshot.data[index].nome_turma));
            },
          );
        }
      },
    );*/
    /*final createChamada = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(35),
      color: Colors.cyan[700],
      child: MaterialButton(
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: (){},
        child: Text('Fazer Chamada', textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
      ),
    );*/
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
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(snapshot.data[index].nome_turma));
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
