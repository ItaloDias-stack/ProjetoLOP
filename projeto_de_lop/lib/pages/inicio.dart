import 'package:flutter/material.dart';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:projeto_de_lop/pages/criarTurma.dart';

class Inicio extends StatefulWidget {
  final Professor prof;
  const Inicio({Key key,this.prof}):super (key:key);
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
          minWidth: MediaQuery.of(context).size.width / 2.7,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CriarTurma(prof: prof)));
          },
          child: Text('Criar Turma',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ));

    final createChamada = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(35),
      color: Colors.cyan[700],
      child: MaterialButton(
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: (){},
        child: Text('Fazer Chamada', textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            new Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:35),
                    Wrap(
                      spacing:5,
                      children: <Widget>[
                        createTurma,createChamada
                      ],
                    )   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
