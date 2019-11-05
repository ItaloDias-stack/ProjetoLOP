import 'package:flutter/material.dart';
import 'package:projeto_de_lop/models/Professor.dart';
import 'package:projeto_de_lop/models/Turma.dart';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:toast/toast.dart';

import 'inicio.dart';

class EditarTurma extends StatefulWidget {
  final Turma turma;
  const EditarTurma({Key key, this.turma}) : super(key: key);
  @override
  _EditarTurmaState createState() => _EditarTurmaState(turma: this.turma);
}

class _EditarTurmaState extends State<EditarTurma> {
  Turma turma;
  _EditarTurmaState({this.turma});
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerCod = new TextEditingController();
    TextEditingController controllerNome = new TextEditingController();

    final nomeTurma = TextField(
      controller: controllerNome,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
        hintText: 'Nome da Turma',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    final codTurma = TextField(
      controller: controllerCod,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
        hintText: 'Código da Turma',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    final update = Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 5,
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () async {
          if (await updateTurma(controllerNome.text,controllerCod.text,turma.id_turma)) {
            Professor professor = await getProfessorById(turma);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Inicio(prof: professor)));
          } else {
            Toast.show("Essa turma já existe", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
            controllerCod.text = "";
            controllerNome.text = "";
          }
        },
        child: Text('Editar Turma',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
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
                    SizedBox(height: 50),
                    Text(
                      'Editar Turma',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 45),
                    nomeTurma,
                    SizedBox(height: 25),
                    codTurma,
                    SizedBox(height: 25),
                    update
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
